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

class LoanApprovedPage extends JourneyStatefulWidget {
  const LoanApprovedPage({super.key}) : super(name: 'LoanApprovedPage');

  @override
  State<LoanApprovedPage> createState() => _LoanApprovedPageState();
}

class _LoanApprovedPageState extends State<LoanApprovedPage> {
  BannerAd? banner;

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.loanApprovedStream,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.loanApprovedStream,
        body: _body(context),
      ),
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
              const Text('Como saber se meu empréstimo foi aprovado',
                  style: TextStyle(
                    color: AppColors.greenDark,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  )),
              const H(32),
              AppBannerAd(AdBannerStorage.loanApprovedStream),
              const H(32),
              Text(
                'Entenda',
                style: AppTheme.title,
              ),
              const H(16),
              Text(
                'Você pode consultar o status do seu empréstimo através destes passos:',
                style: AppTheme.subtitle,
              ),
              _divisor(),
              ...[
                'Após fazer a simulação e finalizar a contratação do serviço, o beneficiário receberá uma mensagem automática no aplicativo contendo as informações principais do empréstimo. Entre os dados estão a taxa de juros, o valor que passará a ser recebido caso ele seja contratado e o valor total a ser pago.',
                'Quando submetido, o pedido será analisado e o resultado da solicitação será divulgado através de uma mensagem no menu “Empréstimos”, do próprio aplicativo Caixa Tem. O prazo de resposta é de, no máximo, 48 horas.',
                'Caso ocorra algum erro ou falha na operação, o usuário poderá contatar a Caixa através dos telefones 121 ou 111. Além disso, é possível ir até uma agência do banco para tirar as dúvidas',
                'Você pode ir até uma agência da caixa e verificar seu pedido, tendo em mãos os seguintes documentos RG e CPF originais',
              ].map((e) => labelItem(e)).toList(),
              Text(
                'Estando dentro dessas condições você poderá fazer o empréstimo',
                style: AppTheme.subtitle,
              ),
              const H(48),
              const PrivacyPolicy(),
              const H(16),
            ],
          ),
        ),
      ],
    );
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
