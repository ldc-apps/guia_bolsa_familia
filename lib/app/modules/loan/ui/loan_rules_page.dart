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

class LoanRulesPage extends JourneyStatefulWidget {
  const LoanRulesPage({super.key}) : super(name: 'LoanRulesPage');

  @override
  State<LoanRulesPage> createState() => _LoanRulesPageState();
}

class _LoanRulesPageState extends State<LoanRulesPage> {
  BannerAd? banner;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.loanRulesStream,
        body: _body(context),
      ),
    );
  }

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.loanRulesStream,
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
              const Text('Conheça as regras do\nEmpréstimo Bolsa Família',
                  style: TextStyle(
                    color: AppColors.greenDark,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  )),
              const H(32),
              AppBannerAd(AdBannerStorage.loanRulesStream),
              const H(32),
              Text(
                'Entenda',
                style: AppTheme.title,
              ),
              const H(16),
              Text(
                'O valor do empréstimo pode comprometer no máximo 40% do valor mensal de recebimento do Bolsa Família.',
                style: AppTheme.subtitle,
              ),
              _divisor(),
              ...[
                'O governo não poderá ser responsabilizado se o empréstimo não for pago ao banco',
                'Valor do desconto mensal: na Caixa varia de R\$  15 a R\$ 160',
                'Documentos exigidos: RG ou carteira de motorista e CPF',
                'A prestação máxima é de R\$ 160, que corresponde a 40% do benefício permanente, de R\$ 400  (o valor original antes do pagamento adicional de R\$ 200, que termina em 31 de dezembro de 2023);',
                'O empréstimo pode ser parcelado em até 24 meses',
                'A parcela mínima é de R\$ 15, variando conforme o valor do crédito liberado',
              ].map((e) => labelItem(e)).toList(),
              Text(
                'Estando dentro dessas regras, o beneficiário poderá simular empréstimo Bolsa Família com a instituição financeira de sua preferência.',
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
