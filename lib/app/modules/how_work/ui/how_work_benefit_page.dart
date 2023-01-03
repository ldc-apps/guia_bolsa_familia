import 'package:aid_brazil/app/ad/ad_banner_storage.dart';
import 'package:aid_brazil/app/ad/ad_controller.dart';
import 'package:aid_brazil/app/components/app_banner_ad.dart';
import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/back.dart';
import 'package:aid_brazil/app/components/back_share.dart';
import 'package:aid_brazil/app/components/bottom_button.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/components/w.dart';
import 'package:aid_brazil/app/modules/how_register/ui/how_register_home_page.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/app_theme.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../components/privacy_policy.dart';

class HowWorkBenefit extends StatefulWidget {
  const HowWorkBenefit({super.key});

  @override
  State<HowWorkBenefit> createState() => _HowWorkBenefitState();
}

class _HowWorkBenefitState extends State<HowWorkBenefit> {
  BannerAd? banner;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.howWorkBenefitStream,
        body: _body(context),
      ),
    );
  }

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.howWorkBenefitStream,
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
                  const Text('Como receber o benefício',
                      style: TextStyle(
                        color: AppColors.greenDark,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      )),
                  const H(16),
                  Text(
                    'Veja as melhores formas de receber seu Bolsa Família!',
                    style: AppTheme.subtitle,
                  ),
                  const H(32),
                  AppBannerAd(AdBannerStorage.howWorkBenefitStream),
                  const H(32),
                  Text(
                    'Documentos',
                    style: AppTheme.title,
                  ),
                  const H(16),
                  Text(
                    'Os benefícios poderão ser pagos por meio das contas:',
                    style: AppTheme.subtitle,
                  ),
                  _divisor(),
                  ...[
                    'Poupança Social Digital;',
                    'Conta Corrente de Depósito à vista;',
                    'Conta Especial de Depósito à vista;',
                    'Conta Contábil (plataforma social do Programa)',
                  ]
                      .map((e) => labelItem(Icons.how_to_reg_outlined, e))
                      .toList(),
                  const H(16),
                  Text(
                    'A abertura da Conta Poupança Social digital para os pagamentos do Bolsa Família, poderá ocorrer de forma automática, em nome do Responsável Familiar inscrito no Cadastro Único.',
                    style: AppTheme.subtitle,
                  ),
                  const H(16),
                  Text(
                    'Caso tenha alguma dúvida ainda, clica aqui abaixo e veja como funciona para se cadastrar.',
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
        BottomButton('COMO SE CADASTRAR', Icons.arrow_forward_ios_sharp, () {
          Navigator.pop(context);
          Navigator.pop(context);
          push(context, const HowRegisterHomePage());
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
