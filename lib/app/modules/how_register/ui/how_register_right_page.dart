import 'package:aid_brazil/app/ad/ad_banner_storage.dart';
import 'package:aid_brazil/app/ad/ad_controller.dart';
import 'package:aid_brazil/app/components/app_banner_ad.dart';
import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/back.dart';
import 'package:aid_brazil/app/components/back_share.dart';
import 'package:aid_brazil/app/components/bottom_button.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/components/module_title.dart';
import 'package:aid_brazil/app/components/w.dart';
import 'package:aid_brazil/app/modules/how_register/how_register_model.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/app_theme.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../components/privacy_policy.dart';

class HowRegisterRightPage extends JourneyStatefulWidget {
  const HowRegisterRightPage({super.key}) : super(name: 'HowRegisterRightPage');

  @override
  State<HowRegisterRightPage> createState() => _HowRegisterRightPageState();
}

class _HowRegisterRightPageState extends State<HowRegisterRightPage> {
  BannerAd? banner;

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.howRegisterRightStream,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.howRegisterRightStream,
        body: _body(context),
      ),
    );
  }

  Widget _body(_) {
    return Stack(
      children: [
        ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const H(16),
                  Back(
                      onTap: () => AdController.showInterstitialAd(context),
                      color: AppColors.greenDark,
                      margin: 0,
                      action: const AppShare(
                        margin: 0,
                      )),
                  const H(32),
                  const Text('Veja se você tem\ndireito.',
                      style: TextStyle(
                        color: AppColors.greenDark,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      )),
                  const H(32),
                  AppBannerAd(AdBannerStorage.howRegisterRightStream),
                  const H(32),
                  Text(
                    'Quem pode participar?',
                    style: AppTheme.title,
                  ),
                  const H(16),
                  Text(
                    '​Podem participar do Programa as famílias nas seguintes situações:',
                    style: AppTheme.subtitle,
                  ),
                  _divisor(),
                  ...[
                    'Famílias em situação de extrema pobreza;',
                    'Famílias em situação de pobreza;',
                    'Famílias em regra de emancipação.'
                  ].map((e) => labelItem(e)).toList(),
                  const H(8),
                  Text(
                      'Essas são as principais regras, porém existem outros detalhes, para verificar se você está dentro de todas as regras, responda nosso questionário clicando abaixo.',
                      style: AppTheme.subtitle),
                  const H(64),
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
                  const H(32),
                  const PrivacyPolicy(),
                  const H(96),
                ],
              ),
            ),
          ],
        ),
        BottomButton('Responda o questionário', Icons.rule_outlined, () {})
      ],
    );
  }

  Widget labelItem(String label) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.how_to_reg_outlined,
              size: 32,
              color: AppColors.green,
            ),
            const W(16),
            Expanded(child: Text(label, style: AppTheme.subtitle)),
          ],
        ),
        _divisor()
      ],
    );
  }

  Padding _divisor() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Divider(
        color: AppColors.grey,
        thickness: 1.6,
        height: 0,
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
