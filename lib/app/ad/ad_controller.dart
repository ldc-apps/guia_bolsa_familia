import 'dart:async';
import 'dart:convert';

import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rxdart/rxdart.dart';

import '../components/splash_page.dart';
import '../enums/module_enum.dart';
import '../models/app_stream.dart';
import '../services/foreground_service.dart';
import '../services/notification_service.dart';
import '../utils/utls_controller.dart';
import 'ad_model.dart';

class AdController {
  static final AppStream<AdConfig> adConfigStream = AppStream<AdConfig>();
  static AdConfig get adConfig => adConfigStream.value;

  static final AppStream<bool> queryEnableStream = AppStream<bool>.seed(true);

  static Future<void> initAdConfig() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 30),
      ));
      // ------
      // final adConfig = AdConfig.fromJson(AdConfig.configDefault);
      // adConfigStream.add(adConfig);
      // ------
      await remoteConfig
          .setDefaults({'ad_config': jsonEncode(AdConfig.configDefault), 'query_enable': true});
      await remoteConfig.fetchAndActivate();
      final enable = remoteConfig.getBool('query_enable');
      queryEnableStream.add(enable);
      final remoteConfigAdConfigValue = remoteConfig.getString('ad_config');
      final decoded = jsonDecode(remoteConfigAdConfigValue);
      final adConfig = AdConfig.fromJson(decoded);
      // ------
      adConfigStream.add(adConfig);
    } catch (e) {
      adConfigStream.add(AdConfig.getDefault());
    }
  }

  //* Intersticial

  static final AppStream<InterstitialAd?> interstitialStream = AppStream<InterstitialAd?>();

  static Future<void> fetchInterstitialAd(List<String> ids, {bool fromNotification = false}) async {
    if (ids.length == adConfig.intersticial.id.length && _canShowIntersticial) {
      return;
    }
    showToast('INTERSTICIAL - ${ids.length}');
    await InterstitialAd.load(
        adUnitId: ids.first,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            showToastLoaded('INTERSTICIAL - ${ids.length}');
            ad.fullScreenContentCallback = _intersticialFullScreenCallback(fromNotification);
            interstitialStream.add(ad);
          },
          onAdFailedToLoad: (LoadAdError error) {
            if (AdConfig.checkWaterFallErrorCode(error.code)) {
              if (ids.isNotEmpty) ids.removeAt(0);
              if (ids.isNotEmpty) {
                fetchInterstitialAd(ids);
              } else {
                interstitialStream.add(null);
              }
            } else {
              interstitialStream.add(null);
            }
          },
        ));
  }

  static FullScreenContentCallback<InterstitialAd> _intersticialFullScreenCallback(
          bool fromNotification) =>
      FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) =>
            _disposeIntersticial(ad, fromNotification),
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) =>
            _disposeIntersticial(ad, fromNotification),
      );

  static void _disposeIntersticial(InterstitialAd ad, bool fromNotification) {
    ad.dispose();
    interstitialStream.add(null);
    UtilsController().ignoringStream.add(false);
    if (fromNotification) Navigator.pop(contextGlobal);
  }

  static Future<bool> showInterstitialAd(BuildContext context,
      {Function? onComplete, bool pop = true}) async {
    if (_canShowIntersticial) {
      ForegroundService.showForegroundBack = false;
      UtilsController().ignoringStream.add(true);
      await interstitialStream.controller.value!.show();
      late StreamSubscription<InterstitialAd?> controller;
      controller = AdController.interstitialStream.controller.listen((InterstitialAd? data) {
        if (data == null) {
          controller.cancel();
          if (pop) Navigator.pop(context);
          if (onComplete != null) onComplete.call();
          ForegroundService.showForegroundBack = true;
        }
      });
      return false;
    } else {
      if (pop) Navigator.pop(context);
      if (onComplete != null) onComplete.call();
      return false;
    }
  }

  static bool get _canShowIntersticial =>
      AdController.adConfig.intersticial.active &&
      interstitialStream.controller.hasValue &&
      interstitialStream.controller.value != null;

  static Future<void> showInsterticialAdNotification(List<String> ids, String url) async {
    ForegroundService.showForegroundBack = false;
    if (AdController.adConfig.intersticial.active) {
      push(contextGlobal, const SplashPage());
    }
    AdController.fetchInterstitialAd(ids,
        fromNotification: AdController.adConfig.intersticial.active);
    late StreamSubscription<InterstitialAd?> controller;
    controller = AdController.interstitialStream.controller.listen((InterstitialAd? data) {
      if (data != null) {
        data.show();
      } else {
        controller.cancel();
      }
    });
  }

  static Future<void> checkAndshowQueryAd({Function? onComplete}) async {
    if (AdController.adConfig.canShowRewardedAd) {
      await AdController.showQueryAd(onComplete: onComplete);
    } else {
      onComplete?.call();
    }
  }

  //* OPENED APP

  static Future<void> fetchOpenedAppAd(List<String> ids, {bool fromBackground = false}) async {
    showToast('OPENEDEDAPP - ${ids.length}');
    await AppOpenAd.load(
      adUnitId: ids.first,
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          showToastLoaded('OPENEDEDAPP - ${ids.length}');
          ad.fullScreenContentCallback = _openedApFullScreenCallback(fromBackground);
          ad.show();
        },
        onAdFailedToLoad: (error) {
          if (AdConfig.checkWaterFallErrorCode(error.code)) {
            if (ids.isNotEmpty) ids.removeAt(0);
            if (ids.isNotEmpty) {
              fetchOpenedAppAd(ids, fromBackground: fromBackground);
            } else {
              _disposeOpenAd();
            }
          } else {
            _disposeOpenAd();
          }
        },
      ),
    );
  }

  static FullScreenContentCallback<AppOpenAd> _openedApFullScreenCallback(
    bool fromBackground,
  ) =>
      FullScreenContentCallback(
        onAdFailedToShowFullScreenContent: (ad, error) =>
            _disposeOpenAd(ad: ad, fromBackground: fromBackground),
        onAdDismissedFullScreenContent: (ad) =>
            _disposeOpenAd(ad: ad, fromBackground: fromBackground),
      );

  static void _disposeOpenAd({
    AppOpenAd? ad,
    bool fromBackground = false,
  }) async {
    if (ad != null) ad.dispose();
    if (fromBackground) {
      Navigator.pop(contextGlobal);
      if (urlToShow != null) {
        execUrl(urlToShow!);
        urlToShow = null;
      }
    } else {
      handleInitialMessage(await FirebaseMessaging.instance.getInitialMessage());
      ForegroundService.showForegroundBack = true;
    }
    UtilsController().moduleStream.add(Module.home);
  }

  static BehaviorSubject<BannerAd?> adBannerStorage = BehaviorSubject<BannerAd?>.seeded(null);

  //* BANNER

  static Future<void> fetchBanner(List<String> ids, BehaviorSubject<BannerAd?> behavior,
      {bool fromStorage = false}) async {
    if (AdController.adConfig.banner.active) {
      if (!fromStorage && adBannerStorage.value != null) {
        behavior.sink.add(adBannerStorage.value);
        adBannerStorage.add(null);
        fetchBanner(ids, adBannerStorage, fromStorage: true);
        return;
      }
      showToast('BANNER | ${fromStorage ? 'PROXIMA' : 'ATUAL'} | ${ids.length}');
      await BannerAd(
        adUnitId: ids.first,
        request: const AdRequest(),
        size: AdSize.mediumRectangle,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            behavior.sink.add(ad as BannerAd);
            if (!fromStorage && adBannerStorage.value == null) {
              fetchBanner(ids, adBannerStorage, fromStorage: true);
            }
            showToastLoaded('BANNER | ${fromStorage ? 'PROXIMA' : 'ATUAL'} | ${ids.length}');
          },
          onAdFailedToLoad: (ad, error) async {
            if (AdConfig.checkWaterFallErrorCode(error.code)) {
              if (ids.isNotEmpty) ids.removeAt(0);
              if (ids.isNotEmpty) {
                await fetchBanner(ids, behavior, fromStorage: fromStorage);
              } else {
                behavior.sink.add(ad as BannerAd);
              }
            } else {
              behavior.sink.add(ad as BannerAd);
            }
          },
        ),
      ).load();
    }
  }

  //* QUERY

  static Future<void> fetchQueryAd() async {
    if (adConfig.rewarded.active) {
      fetchRewardAd(adConfig.rewarded.id);
    } else if (adConfig.intersticialRewarded.active) {
      fetchIntersticialRewardAd(adConfig.intersticialRewarded.id);
    } else {
      fetchRewardAd(adConfig.intersticialRewarded.id);
    }
  }

  static Future<void> showQueryAd({Function? onComplete}) async {
    if (adConfig.rewarded.active) {
      showRewardAd(onComplete: onComplete);
    } else if (adConfig.intersticialRewarded.active) {
      showRewardedIntersticialAd(onComplete: onComplete);
    } else {
      showRewardAd(onComplete: onComplete);
    }
  }

  //* REWARD

  static final AppStream<bool> rewardedLoadingStream = AppStream<bool>.seed(true);
  static final AppStream<RewardedAd?> rewardedStream = AppStream<RewardedAd?>();

  static Future<void> fetchRewardAd(List<String> ids, {Function? onComplete}) async {
    ForegroundService.showForegroundBack = false;
    showToast('REWARDED - ${ids.length}');
    await RewardedAd.load(
      adUnitId: ids.first,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          showToastLoaded('REWARDED - ${ids.length}');
          ad.fullScreenContentCallback = _rewardFullScreenCallback;
          rewardedLoadingStream.add(false);
          rewardedStream.add(ad);
          if (onComplete != null) onComplete.call();
        },
        onAdFailedToLoad: (LoadAdError error) async {
          if (AdConfig.checkWaterFallErrorCode(error.code)) {
            if (ids.isNotEmpty) ids.removeAt(0);
            if (ids.isNotEmpty) {
              await fetchRewardAd(ids, onComplete: onComplete);
            } else {
              _disposeRewardedAd(true);
            }
          } else {
            _disposeRewardedAd(true);
          }
        },
      ),
    );
  }

  static final FullScreenContentCallback<RewardedAd> _rewardFullScreenCallback =
      FullScreenContentCallback(
    onAdDismissedFullScreenContent: (RewardedAd ad) => _disposeRewardedAd(true, ad),
    onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) =>
        _disposeRewardedAd(true, ad),
  );

  static void _disposeRewardedAd(data, [RewardedAd? ad]) {
    if (ad != null) {
      ad.dispose();
    }
    rewardedStream.add(null);
    rewardedLoadingStream.add(false);
    ForegroundService.showForegroundBack = true;
  }

  static void showRewardAd({Function? onComplete}) async {
    if (rewardedStream.value != null) {
      rewardedStream.value!.show(
        onUserEarnedReward: (ad, reward) {
          ForegroundService.showForegroundBack = true;
          onComplete?.call();
        },
      );
      rewardedLoadingStream.add(true);
      fetchRewardAd(adConfig.rewarded.id);
    } else {
      rewardedLoadingStream.add(true);
      fetchRewardAd(adConfig.rewarded.id, onComplete: onComplete);
    }
  }

  //* INTERSTICIAL REWARD

  static final AppStream<bool> rewardedIntersticialLoadingStream = AppStream<bool>.seed(true);
  static final AppStream<RewardedInterstitialAd?> rewardedIntersticialStream =
      AppStream<RewardedInterstitialAd?>();

  static Future<void> fetchIntersticialRewardAd(List<String> ids, {Function? onShow}) async {
    ForegroundService.showForegroundBack = false;
    showToast("INTERSTICIAL REWARD - ${ids.length}");
    await RewardedInterstitialAd.load(
      adUnitId: ids.first,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {
          showToastLoaded('INTERSTICIAL REWARDED - ${ids.length}');
          ad.fullScreenContentCallback = _rewardIntersticialFullScreenCallback;
          rewardedIntersticialLoadingStream.add(false);
          rewardedIntersticialStream.add(ad);
          if (onShow != null) onShow.call();
        },
        onAdFailedToLoad: (LoadAdError error) async {
          if (AdConfig.checkWaterFallErrorCode(error.code)) {
            if (ids.isNotEmpty) ids.removeAt(0);
            if (ids.isNotEmpty) {
              await fetchIntersticialRewardAd(ids, onShow: onShow);
            } else {
              _disposeRewardedIntersticialAd(true);
            }
          } else {
            _disposeRewardedIntersticialAd(true);
          }
        },
      ),
    );
  }

  static final FullScreenContentCallback<RewardedInterstitialAd>
      _rewardIntersticialFullScreenCallback = FullScreenContentCallback(
    onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) =>
        _disposeRewardedIntersticialAd(true, ad),
    onAdFailedToShowFullScreenContent: (RewardedInterstitialAd ad, AdError error) =>
        _disposeRewardedIntersticialAd(true, ad),
  );

  static void _disposeRewardedIntersticialAd(data, [RewardedInterstitialAd? ad]) {
    if (ad != null) {
      ad.dispose();
    }
    rewardedIntersticialStream.add(null);
    rewardedIntersticialLoadingStream.add(false);
    ForegroundService.showForegroundBack = true;
    // Navigator.pop(contextGlobal, data);
  }

  static void showRewardedIntersticialAd({Function? onComplete}) async {
    if (rewardedIntersticialStream.value != null) {
      rewardedIntersticialStream.value!.show(
        onUserEarnedReward: (ad, reward) {
          ForegroundService.showForegroundBack = true;
          onComplete?.call();
        },
      );
    } else {
      rewardedLoadingStream.add(true);
      fetchRewardAd(adConfig.rewarded.id,
          onComplete: () => showRewardedIntersticialAd(onComplete: onComplete));
    }
  }

  static pushReplaceAndShowIntersticial(BuildContext context, Widget page) async {
    await showInterstitialAd(context, onComplete: () {
      Navigator.of(context).popUntil((route) => route.isFirst);
      push(context, page);
    });
  }

  static void showToast(String text) {
    try {
      // ScaffoldMessenger.of(contextGlobal).showSnackBar(SnackBar(
      //   content: Text(text),
      //   duration: const Duration(seconds: 1),
      // ));
    } catch (e) {}
  }

  static void showToastLoaded(String text) {
    try {
      // ScaffoldMessenger.of(contextGlobal).showSnackBar(SnackBar(
      //   content: Text(text),
      //   backgroundColor: Colors.green,
      //   duration: const Duration(seconds: 1),
      // ));
    } catch (e) {}
  }
}
