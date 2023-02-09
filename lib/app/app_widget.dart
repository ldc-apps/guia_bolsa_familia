import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:overlay_support/overlay_support.dart';

import 'ad/ad_controller.dart';
import 'app_controller.dart';
import 'enums/module_enum.dart';
import 'modules/new/new_controller.dart';
import 'services/route_service.dart';
import 'utils/theme_utils.dart';
import 'utils/utls_controller.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppController _appController = AppController();

  @override
  void initState() {
    super.initState();
    MobileAds.instance.initialize().then((value) {
      if (AdController.adConfig.appOpen.active) {
        AdController.fetchOpenedAppAd(AdController.adConfig.appOpen.id);
      } else {
        UtilsController().moduleStream.add(Module.home);
      }
    });
    NewController().init();
    AdController.fetchBanner(
        AdController.adConfig.banner.id, AdController.adBannerStorage);
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: _appController.key,
        title: 'Guia Bolsa Família 2023',
        theme: ThemeUtils.theme,
        initialRoute: RouteService.initial,
        routes: RouteService.routes,
      ),
    );
  }
}
