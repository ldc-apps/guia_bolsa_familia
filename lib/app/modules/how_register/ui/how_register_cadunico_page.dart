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
                  const Text('Cadastro no\nCadÚnico.',
                      style: TextStyle(
                        color: AppColors.greenDark,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      )),
                  const H(16),
                  Text(
                      'Saiba como fazer o seu cadastro ou atualizar seu CadÚnico',
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
                    '​O Responsável Familiar deve comparecer ao CRAS levando os seguintes documentos',
                    style: AppTheme.subtitle,
                  ),
                  _divisor(),
                  ...['CPF', 'Título de eleitor', 'Comprovante de residência']
                      .map((e) => labelItem(Icons.check, e))
                      .toList(),
                  Text(
                      'É importante levar uma cópia de cada um desses documentos para cada membro da família.',
                      style: AppTheme.subtitle),
                  const H(12),
                  Text(
                      'É possível também fazer um pré cadastro via Aplicativo CadÚnico, veja algumas informações importantes:',
                      style: AppTheme.subtitle),
                  const H(24),
                  _divisor(),
                  ...[
                    'Não é obrigatório fazer seu pré-cadastro;',
                    'Mesmo fazendo o pré-cadastro você ainda precisa comparecer a um CRAS;',
                    'O pré-cadastro funciona para agilizar seu atendimento presencial;',
                    'O pré-cadastro via aplicativo é válido por 60 dias até o comparecimento em um CRAS.'
                  ].map((e) => labelItem(Icons.verified_outlined, e)).toList(),
                  const H(16),
                  Text(
                    'No caso de atualização do seu CadÚnico',
                    style: AppTheme.title,
                  ),
                  const H(16),
                  Text(
                    'A atualização deve ser feita diretamente em uma unidade do CRAS Mais próxima de você Atualização deve ser feita a cada 2 anos. ',
                    style: AppTheme.subtitle,
                  ),
                  const H(16),
                  Text(
                    'Porém, se houver qualquer mudança na situação dos membros que compõem o grupo familiar, antes dos dois anos, o cadastro também deverá ser atualizado.',
                    style: AppTheme.subtitle,
                  ),
                  const H(16),
                  Text(
                    'Veja em quais situações o cadastro deve ser atualizado antes do período de dois anos:',
                    style: AppTheme.subtitle,
                  ),
                  const H(24),
                  _divisor(),
                  ...[
                    'Nascimento ou morte de alguém na família;',
                    'Saída de um membro da família para outra casa;',
                    'Mudança de endereço;.'
                        'Entrada das crianças na escola ou transferência de escola;'
                        'Aumento ou diminuição da renda.'
                  ].map((e) => labelItem(Icons.verified_outlined, e)).toList(),
                  const H(16),
                  Text(
                    'Caso a família fique mais de quatro anos sem atualizar as informações cadastrais corre o risco de ser excluída do Cadastro Único.',
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
