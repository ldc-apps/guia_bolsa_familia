import 'package:aid_brazil/app/components/app_shimmer.dart';
import 'package:aid_brazil/app/components/banner_transparent.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rxdart/rxdart.dart';

class AppBannerAd extends StatefulWidget {
  final BehaviorSubject<BannerAd?> behavior;

  const AppBannerAd(
    this.behavior, {
    Key? key,
  }) : super(key: key);

  @override
  State<AppBannerAd> createState() => _AppBannerAdState();
}

class _AppBannerAdState extends State<AppBannerAd> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[100],
      ),
      child: Center(
        child: StreamBuilder<BannerAd?>(
          stream: widget.behavior.stream,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data != null) {
                return SizedBox(
                    width: snapshot.data!.size.width.toDouble(),
                    height: snapshot.data!.size.height.toDouble(),
                    child: AdWidget(ad: snapshot.data!));
              } else {
                return const BannerTransparent();
              }
            } else {
              return const AppShimmer(child: BannerTransparent());
            }
          },
        ),
      ),
    );
  }
}
