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

class HowWorkAvailableFor extends StatefulWidget {
  const HowWorkAvailableFor({super.key});

  @override
  State<HowWorkAvailableFor> createState() => _HowWorkAvailableForState();
}

class _HowWorkAvailableForState extends State<HowWorkAvailableFor> {
  BannerAd? banner;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.howWorkAvailableStream,
        body: _body(context),
      ),
    );
  }

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.howWorkAvailableStream,
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
                  const Text('Quem pode participar do Bolsa Fam??lia',
                      style: TextStyle(
                        color: AppColors.greenDark,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      )),
                  const H(16),
                  Text(
                    'Veja quem pode participar do Bolsa Fam??lia',
                    style: AppTheme.subtitle,
                  ),
                  const H(32),
                  AppBannerAd(AdBannerStorage.howWorkAvailableStream),
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
                    'Podem participar do Programa as fam??lias em situa????o de pobreza ou extrema pobreza que tenham, em sua composi????o, gestantes, nutrizes (m??es que amamentam), crian??as, adolescentes e jovens entre 0 e 21 anos incompletos.',
                    'As fam??lias extremamente pobres s??o aquelas que t??m renda familiar por pessoa mensal igual ou inferior a R\$ 105,00 (cento e cinco reais). As fam??lias pobres s??o aquelas que t??m renda familiar por pessoa de R\$ 105,01 (cento e cinco reais e um centavo) e R\$ 218,00 (duzentos e dezoito reais).',
                    'Para se candidatar ao Programa ?? necess??rio que a fam??lia esteja inscrita no Cadastro ??nico para Programas Sociais do Governo Federal e tenha atualizado seus dados cadastrais nos ??ltimos 2 anos.',
                    'Caso atenda aos requisitos de renda e n??o esteja inscrito, procure o respons??vel pelo Programa Bolsa Fam??lia na prefeitura de sua cidade para realizar o cadastramento no Cadastro ??nico.',
                    'Mantenha seus dados sempre atualizados, informando ?? prefeitura qualquer mudan??a de endere??o, telefone de contato e composi????o da sua fam??lia, como: nascimento, morte, casamento, separa????o e ado????o.',
                    'O cadastramento ?? um pr??-requisito, mas n??o implica a entrada imediata da fam??lia no Programa. Mensalmente, o Minist??rio da Cidadania seleciona, de forma automatizada, as fam??lias que ser??o inclu??das para receber o benef??cio.',
                  ].map((e) => labelItem(Icons.check, e)).toList(),
                  const H(16),
                  Text(
                    'Participe!',
                    style: AppTheme.title,
                  ),
                  const H(16),
                  Text(
                    'Voc?? pode participar do programa estando dentro desses requisitos.Para saber se voc?? tem direito veja clicando aqui se voc?? pode ou n??o receber o Bolsa Fam??lia',
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
