import 'package:aid_brazil/app/ad/ad_banner_storage.dart';
import 'package:aid_brazil/app/ad/ad_controller.dart';
import 'package:aid_brazil/app/components/app_banner_ad.dart';
import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/back.dart';
import 'package:aid_brazil/app/components/back_share.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/components/w.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/app_theme.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../components/privacy_policy.dart';

class HowRegisterCadunicoPage extends JourneyStatefulWidget {
  const HowRegisterCadunicoPage({super.key}) : super(name: 'HowRegisterCadunicoPage');

  @override
  State<HowRegisterCadunicoPage> createState() =>
      _HowRegisterCadunicoPageState();
}

class _HowRegisterCadunicoPageState extends State<HowRegisterCadunicoPage> {
  BannerAd? banner;

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.howRegisterCadunicoStream,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.howRegisterCadunicoStream,
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
                  const Text('Cadastro no\nCad??nico.',
                      style: TextStyle(
                        color: AppColors.greenDark,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      )),
                  const H(16),
                  Text(
                      'Saiba como fazer o seu cadastro ou atualizar seu Cad??nico',
                      style: AppTheme.subtitle),
                  const H(32),
                  AppBannerAd(AdBannerStorage.howRegisterCadunicoStream),
                  const H(32),
                  Text(
                    'Como fazer?',
                    style: AppTheme.title,
                  ),
                  const H(16),
                  Text(
                    '???O Respons??vel Familiar deve comparecer ao CRAS levando os seguintes documentos',
                    style: AppTheme.subtitle,
                  ),
                  _divisor(),
                  ...['CPF', 'T??tulo de eleitor', 'Comprovante de resid??ncia']
                      .map((e) => labelItem(Icons.check, e))
                      .toList(),
                  Text(
                      '?? importante levar uma c??pia de cada um desses documentos para cada membro da fam??lia.',
                      style: AppTheme.subtitle),
                  const H(12),
                  Text(
                      '?? poss??vel tamb??m fazer um pr?? cadastro via Aplicativo Cad??nico, veja algumas informa????es importantes:',
                      style: AppTheme.subtitle),
                  const H(24),
                  _divisor(),
                  ...[
                    'N??o ?? obrigat??rio fazer seu pr??-cadastro;',
                    'Mesmo fazendo o pr??-cadastro voc?? ainda precisa comparecer a um CRAS;',
                    'O pr??-cadastro funciona para agilizar seu atendimento presencial;',
                    'O pr??-cadastro via aplicativo ?? v??lido por 60 dias at?? o comparecimento em um CRAS.'
                  ].map((e) => labelItem(Icons.verified_outlined, e)).toList(),
                  const H(16),
                  Text(
                    'No caso de atualiza????o do seu Cad??nico',
                    style: AppTheme.title,
                  ),
                  const H(16),
                  Text(
                    'A atualiza????o deve ser feita diretamente em uma unidade do CRAS Mais pr??xima de voc?? Atualiza????o deve ser feita a cada 2 anos. ',
                    style: AppTheme.subtitle,
                  ),
                  const H(16),
                  Text(
                    'Por??m, se houver qualquer mudan??a na situa????o dos membros que comp??em o grupo familiar, antes dos dois anos, o cadastro tamb??m dever?? ser atualizado.',
                    style: AppTheme.subtitle,
                  ),
                  const H(16),
                  Text(
                    'Veja em quais situa????es o cadastro deve ser atualizado antes do per??odo de dois anos:',
                    style: AppTheme.subtitle,
                  ),
                  const H(24),
                  _divisor(),
                  ...[
                    'Nascimento ou morte de algu??m na fam??lia;',
                    'Sa??da de um membro da fam??lia para outra casa;',
                    'Mudan??a de endere??o;.'
                        'Entrada das crian??as na escola ou transfer??ncia de escola;'
                        'Aumento ou diminui????o da renda.'
                  ].map((e) => labelItem(Icons.verified_outlined, e)).toList(),
                  const H(16),
                  Text(
                    'Caso a fam??lia fique mais de quatro anos sem atualizar as informa????es cadastrais corre o risco de ser exclu??da do Cadastro ??nico.',
                    style: AppTheme.subtitle,
                  ),
                  const H(42),
                  const PrivacyPolicy(),
                  const H(96),
                ],
              ),
            ),
          ],
        ),
        // BottomButton('ENCONTRAR UM CRAS', Icons.location_on_outlined, () {})
      ],
    );
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
