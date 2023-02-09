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
              const Text('Aprovação no Bolsa Família\nBrasil',
                  style: TextStyle(
                    color: AppColors.greenDark,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  )),
              const H(16),
              Text('Descubra como saber se você foi aprovado no Bolsa Família',
                  style: AppTheme.subtitle),
              const H(32),
              AppBannerAd(AdBannerStorage.howRegisterAprovacaoStream),
              const H(32),
              Text(
                'Saiba se você foi aprovado',
                style: AppTheme.title,
              ),
              const H(16),
              Text(
                'Veja abaixo como acompanhar a sua aprovação no Bolsa Família após o seu Cadastro Único.',
                style: AppTheme.subtitle,
              ),
              _divisor(),
              ...[
                'Para saber se o cadastro foi aprovado após a entrega de documentos e entrevista social, o Responsável da Família  pode fazer a consulta no site CadÚnico, pelo aplicativo Cadastro Único ou aplicativo do Bolsa Família.',
                'Quando seu benefício for concedido, a CAIXA enviará correspondência para a residência comunicando a seleção para o Programa, de acordo com o endereço informado no Cadastro Único.',
                'Também é possível consultar a situação do benefício via Atendimento CAIXA Auxilio Brasil pelo telefone 111, e pelo aplicativo CAIXA Tem.',
                'Também é possível fazer a consulta ligando para a Central de Relacionamento do Bolsa Família, no número 121, de segunda a sexta-feira, das 7h às 19h. A ligação é gratuita.',
                'Cada familiar terá direito a um Número de Identificação Social, o NIS, que será disponibilizado assim que sua aprovação for concedida.',
              ].map((e) => labelItem(e)).toList(),
              const H(8),
              Text(
                  'Pronto, após verificar sua aprovação veja no próximo passo como receber seu Bolsa Família.',
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
