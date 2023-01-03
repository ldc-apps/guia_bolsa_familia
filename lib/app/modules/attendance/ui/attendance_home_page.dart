import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../ad/ad_banner_storage.dart';
import '../../../ad/ad_controller.dart';
import '../../../components/app_banner_ad.dart';
import '../../../components/app_card.dart';
import '../../../components/app_scaffold.dart';
import '../../../components/back.dart';
import '../../../components/background_gradient.dart';
import '../../../components/h.dart';
import '../../../components/module_title.dart';
import '../../../components/page_title.dart';
import '../../../components/privacy_policy.dart';
import '../attendance_model.dart';

class AttendanceHomePage extends StatefulWidget {
  const AttendanceHomePage({super.key});

  @override
  State<AttendanceHomePage> createState() => _AttendanceHomePageState();
}

class _AttendanceHomePageState extends State<AttendanceHomePage> {
  BannerAd? banner;

  Widget bodyStacked(BuildContext _) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ContainerBackground(
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Back(
                onTap: () => AdController.showInterstitialAd(context),
              ),
              const H(8),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: PageTitle('Atendimento',
                      'Veja  abaixo  todas  as  opções  para  atendimento  sobre  o  Bolsa Família.'))
            ],
          ),
        ),
        const H(4),
        _body(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.attendanceHomeStream,
        body: bodyStacked(context),
      ),
    );
  }

  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.attendanceHomeStream,
    );
    super.initState();
  }

  Widget _body(BuildContext _) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            transform: Matrix4.translationValues(0, -140, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBannerAd(AdBannerStorage.attendanceHomeStream),
                const H(32),
                const ModuleTitle('Canais de', 'Atendimento', boldBottom: true),
                const H(24),
                for (var e in AttendanceHome.itens(_))
                  AppCard(
                    title: e.title,
                    subtitle: e.subtitle,
                    icon: e.icon,
                    function: e.onTap,
                  ),
              ],
            ),
          ),
          const PrivacyPolicy()
        ],
      ),
    );
  }
}
