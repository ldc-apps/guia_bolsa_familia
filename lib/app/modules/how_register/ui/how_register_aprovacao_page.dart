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

class HowRegisterAprovacaoPage extends JourneyStatefulWidget {
  const HowRegisterAprovacaoPage({super.key}) : super(name: 'HowRegisterAprovacaoPage');

  @override
  State<HowRegisterAprovacaoPage> createState() =>
      _HowRegisterAprovacaoPageState();
}

class _HowRegisterAprovacaoPageState extends State<HowRegisterAprovacaoPage> {
  BannerAd? banner;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.howRegisterAprovacaoStream,
        body: _body(context),
      ),
    );
  }

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.howRegisterAprovacaoStream,
    );
    super.initState();
  }

  Widget labelItem(String label) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.check_outlined,
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
    return ListView(
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
              const Text('Aprova????o no Bolsa Fam??lia\nBrasil',
                  style: TextStyle(
                    color: AppColors.greenDark,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  )),
              const H(16),
              Text('Descubra como saber se voc?? foi aprovado no Bolsa Fam??lia',
                  style: AppTheme.subtitle),
              const H(32),
              AppBannerAd(AdBannerStorage.howRegisterAprovacaoStream),
              const H(32),
              Text(
                'Saiba se voc?? foi aprovado',
                style: AppTheme.title,
              ),
              const H(16),
              Text(
                'Veja abaixo como acompanhar a sua aprova????o no Bolsa Fam??lia ap??s o seu Cadastro ??nico.',
                style: AppTheme.subtitle,
              ),
              _divisor(),
              ...[
                'Para saber se o cadastro foi aprovado ap??s a entrega de documentos e entrevista social, o Respons??vel da Fam??lia  pode fazer a consulta no site Cad??nico, pelo aplicativo Cadastro ??nico ou aplicativo do Bolsa Fam??lia.',
                'Quando seu benef??cio for concedido, a CAIXA enviar?? correspond??ncia para a resid??ncia comunicando a sele????o para o Programa, de acordo com o endere??o informado no Cadastro ??nico.',
                'Tamb??m ?? poss??vel consultar a situa????o do benef??cio via Atendimento CAIXA Auxilio Brasil pelo telefone 111, e pelo aplicativo CAIXA Tem.',
                'Tamb??m ?? poss??vel fazer a consulta ligando para a Central de Relacionamento do Bolsa Fam??lia, no n??mero 121, de segunda a sexta-feira, das 7h ??s 19h. A liga????o ?? gratuita.',
                'Cada familiar ter?? direito a um N??mero de Identifica????o Social, o NIS, que ser?? disponibilizado assim que sua aprova????o for concedida.',
              ].map((e) => labelItem(e)).toList(),
              const H(8),
              Text(
                  'Pronto, ap??s verificar sua aprova????o veja no pr??ximo passo como receber seu Bolsa Fam??lia.',
                  style: AppTheme.subtitle),
              const H(32),
              const PrivacyPolicy(),
              const H(16),
            ],
          ),
        ),
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
