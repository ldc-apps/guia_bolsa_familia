import 'package:aid_brazil/app/ad/ad_banner_storage.dart';
import 'package:aid_brazil/app/ad/ad_controller.dart';
import 'package:aid_brazil/app/components/app_banner_ad.dart';
import 'package:aid_brazil/app/components/app_card.dart';
import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/back.dart';
import 'package:aid_brazil/app/components/background_gradient.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/components/module_title.dart';
import 'package:aid_brazil/app/components/page_title.dart';
import 'package:aid_brazil/app/modules/how_register/how_register_model.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../components/privacy_policy.dart';

class HowRegisterHomePage extends JourneyStatefulWidget {
  const HowRegisterHomePage({super.key}) : super(name: 'HowRegisterHomePage');

  @override
  State<HowRegisterHomePage> createState() => _HowRegisterHomePageState();
}

class _HowRegisterHomePageState extends State<HowRegisterHomePage> {
  BannerAd? banner;

  Widget bodyStacked(_) {
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
                  child: PageTitle('Como se cadastrar',
                      'Veja   abaixo   o   passo   a   passo   necessário   para   se   cadastrar   no   Bolsa Família'))
            ],
          ),
        ),
        const H(32),
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
        behavior: AdBannerStorage.howRegisterHomeStream,
        body: bodyStacked(context),
      ),
    );
  }

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.howRegisterHomeStream,
    );
    super.initState();
  }

  Widget _body(_) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            transform: Matrix4.translationValues(0, -140, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBannerAd(AdBannerStorage.howRegisterHomeStream),
                const H(32),
                const ModuleTitle('Maneiras de', 'Cadastrar-se',
                    boldBottom: true),
                const H(24),
                for (var e in HowRegisterItem.itens(_))
                  AppCard(
                    title: e.title,
                    subtitle: e.subtitle,
                    icon: Icons.arrow_forward_ios_outlined,
                    function: () => push(context, e.widget),
                  ),
                const H(16),
                const ModuleTitle(
                  'Perguntas',
                  'Frequentes',
                  boldBottom: true,
                ),
                const H(24),
                Theme(
                    data: ThemeData(dividerColor: Colors.transparent),
                    child: Column(
                      children: [
                        for (var e in DoubtHowRegisterItem.itens(_))
                          _itemDoubtHowRegister(context, e),
                      ],
                    )),
              ],
            ),
          ),
          const PrivacyPolicy()
        ],
      ),
    );
  }

  Widget _itemDoubtHowRegister(
      BuildContext context, DoubtHowRegisterItem item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          childrenPadding:
              const EdgeInsets.only(bottom: 16, right: 16, left: 16),
          collapsedIconColor: AppColors.greenDark,
          iconColor: AppColors.greenDark,
          title: Text(
            item.title,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColors.greenDark),
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          expandedAlignment: Alignment.centerLeft,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(item.subtitle,
                  style: const TextStyle(
                      color: AppColors.greenDark, fontSize: 18, height: 1.4)),
            )
          ],
        ),
      ),
    );
  }
}
