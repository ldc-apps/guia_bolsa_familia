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
import 'package:aid_brazil/app/utils/global_resources.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../components/privacy_policy.dart';

class HowWorkHowGet extends StatefulWidget {
  const HowWorkHowGet({super.key});

  @override
  State<HowWorkHowGet> createState() => _HowWorkHowGetState();
}

class _HowWorkHowGetState extends State<HowWorkHowGet> {
  BannerAd? banner;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.howWorkHowGetStream,
        body: _body(context),
      ),
    );
  }

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.howWorkHowGetStream,
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
                  const Text('Como conseguir o Bolsa Família',
                      style: TextStyle(
                        color: AppColors.greenDark,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      )),
                  const H(16),
                  Text(
                    'Descubra como faz para conseguir o Bolsa Família',
                    style: AppTheme.subtitle,
                  ),
                  const H(32),
                  AppBannerAd(AdBannerStorage.howWorkHowGetStream),
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
                    'Famílias em regra de emancipação.',
                  ]
                      .map((e) => labelItem(Icons.how_to_reg_outlined, e))
                      .toList(),
                  const H(16),
                  Text(
                    'Documentos',
                    style: AppTheme.title,
                  ),
                  const H(16),
                  Text(
                    'Você deve ter em mãos os seguintes documentos:',
                    style: AppTheme.subtitle,
                  ),
                  _divisor(),
                  ...[
                    'Certidão de nascimento',
                    'Comprovante de residência',
                    'Certidão de casamento - caso seja casado(a)',
                    'CPF',
                    'RG',
                    'Carteira de trabalho',
                    'Título de eleitor',
                    'Registro Administrativo de nascimento indígina (RANI) No caso se a pessoa for indígina.',
                  ].map((e) => labelItem(Icons.check, e)).toList(),
                  const H(16),
                  Text(
                    'Após reunir toda a documentação necessária procure o CRAS mais próximo de sua casa e levando toda sua documentação.',
                    style: AppTheme.subtitle,
                  ),
                  const H(32),
                  Text(
                    'Participe!',
                    style: AppTheme.title,
                  ),
                  const H(16),
                  Text(
                    'Essas são as principais regras, porém existem outros detalhes, para verificar se você está dentro de todas as regras, responda nosso questionário clicando abaixo.',
                    style: AppTheme.subtitle,
                  ),
                  const H(48),
                  const PrivacyPolicy(),
                  const H(96),
                ],
              ),
            ),
          ],
        ),
        BottomButton('SAIBA SE VOCÊ TEM DIREITO', Icons.rule, () {
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
