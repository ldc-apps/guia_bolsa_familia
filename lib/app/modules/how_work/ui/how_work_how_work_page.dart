import 'package:aid_brazil/app/ad/ad_banner_storage.dart';
import 'package:aid_brazil/app/ad/ad_controller.dart';
import 'package:aid_brazil/app/components/app_banner_ad.dart';
import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/back.dart';
import 'package:aid_brazil/app/components/back_share.dart';
import 'package:aid_brazil/app/components/bottom_button.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/components/w.dart';
import 'package:aid_brazil/app/modules/quiz/ui/quiz_home_page.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/app_theme.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../components/privacy_policy.dart';

class HowWorkHowWorkPage extends JourneyStatefulWidget {
  const HowWorkHowWorkPage({super.key}) : super(name: 'HowWorkHowWorkPage');

  @override
  State<HowWorkHowWorkPage> createState() => _HowWorkHowWorkPageState();
}

class _HowWorkHowWorkPageState extends State<HowWorkHowWorkPage> {
  BannerAd? banner;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.howWorkHowWorkStream,
        body: _body(context),
      ),
    );
  }

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.howWorkHowWorkStream,
    );
    super.initState();
  }

  Widget labelItem(IconData icon, String label) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
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
                  const Text('O\'Que ?? o Bolsa Fam??lia',
                      style: TextStyle(
                        color: AppColors.greenDark,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      )),
                  const H(32),
                  AppBannerAd(AdBannerStorage.howWorkHowWorkStream),
                  const H(32),
                  Text(
                    'Entenda',
                    style: AppTheme.title,
                  ),
                  const H(16),
                  Text(
                    '???O Bolsa Fam??lia ?? um programa assistencial que todo m??s distribui renda para v??rias fam??lias brasileiras.',
                    style: AppTheme.subtitle,
                  ),
                  _divisor(),
                  ...[
                    'O Bolsa Fam??lia integra em apenas um programa v??rias pol??ticas p??blicas de assist??ncia social, sa??de, educa????o, emprego e renda.',
                    'O novo programa social de transfer??ncia direta e indireta de renda ?? destinado ??s fam??lias em situa????o de pobreza e de extrema pobreza em todo o pa??s.',
                    'Al??m de garantir uma renda b??sica a essas fam??lias, o programa busca simplificar a cesta de benef??cios e estimular a emancipa????o dessas fam??lias para que alcancem autonomia e superem situa????es de vulnerabilidade social.',
                    'O Bolsa Fam??lia ?? coordenado pelo Minist??rio da Cidadania, respons??vel por gerenciar os benef??cios do programa e o envio de recursos para pagamento.',
                  ].map((e) => labelItem(Icons.check, e)).toList(),
                  const H(16),
                  Text(
                    'Participe!',
                    style: AppTheme.title,
                  ),
                  const H(16),
                  Text(
                    'Voc?? pode ver se tem direito ao Bolsa Fam??lia em nosso question??rio clicando aqui embaixo',
                    style: AppTheme.subtitle,
                  ),
                  const H(32),
                  const PrivacyPolicy(),
                  const H(96),
                ],
              ),
            ),
          ],
        ),
        BottomButton('SAIBA SE VOC?? TEM DIREITO', Icons.rule, () {
          Navigator.pop(context);
          Navigator.pop(context);
          push(context, const QuizHomePage());
        })
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
}
