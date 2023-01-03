import 'package:aid_brazil/app/ad/ad_banner_storage.dart';
import 'package:aid_brazil/app/components/app_banner_ad.dart';
import 'package:aid_brazil/app/components/app_card.dart';
import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/back.dart';
import 'package:aid_brazil/app/components/background_gradient.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/components/module_title.dart';
import 'package:aid_brazil/app/components/page_title.dart';
import 'package:aid_brazil/app/components/privacy_policy.dart';
import 'package:aid_brazil/app/modules/how_work/how_work_model.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../ad/ad_controller.dart';

class HowWorkHomePage extends StatefulWidget {
  const HowWorkHomePage({Key? key}) : super(key: key);

  @override
  State<HowWorkHomePage> createState() => _HowWorkHomePageState();
}

class _HowWorkHomePageState extends State<HowWorkHomePage> {
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
                  child: PageTitle('Como funciona e valores',
                      'Veja   como   funciona   o   Bolsa Família   e   os   valores   do   Benefício.'))
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
        behavior: AdBannerStorage.howWorkHomeStream,
        body: bodyStacked(context),
      ),
    );
  }

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.howWorkHomeStream,
    );
    super.initState();
  }

  Widget _body(BuildContext _) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            transform: Matrix4.translationValues(0, -90, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBannerAd(AdBannerStorage.howWorkHomeStream),
                const H(32),
                const ModuleTitle('Entenda', 'Como funciona', boldBottom: true),
                const H(24),
                for (var e in HowWorkHome.itens(_))
                  AppCard(
                    title: e.title,
                    subtitle: e.subtitle,
                    icon: Icons.arrow_forward_ios_outlined,
                    function: () => push(context, e.widget),
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
