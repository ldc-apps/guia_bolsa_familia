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
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../components/privacy_policy.dart';

class LoanRightsPage extends StatefulWidget {
  const LoanRightsPage({super.key});

  @override
  State<LoanRightsPage> createState() => _LoanRightsPageState();
}

class _LoanRightsPageState extends State<LoanRightsPage> {
  BannerAd? banner;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.loanRightsStream,
        body: _body(context),
      ),
    );
  }

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.loanRightsStream,
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
              const Text('Saiba se você tem direito',
                  style: TextStyle(
                    color: AppColors.greenDark,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  )),
              const H(32),
              AppBannerAd(AdBannerStorage.loanRightsStream),
              const H(32),
              Text(
                'Entenda',
                style: AppTheme.title,
              ),
              const H(16),
              Text(
                'O empréstimo Bolsa Família é destinado unicamente aos beneficiários deste programa, ou seja, cidadãos que recebem o benefício por estarem em situação de vulnerabilidade social.',
                style: AppTheme.subtitle,
              ),
              _divisor(),
              ...[
                'Os clientes devem estar com o benefício ativo e recebendo há mais de 90 dias',
                'O responsável familiar cadastrado no Bolsa Família precisa autorizar o empréstimo e o desconto no benefício',
                'Será preciso autorizar a instituição financeira a ter acesso a informações pessoais e bancárias',
                'O beneficiário terá que assinar um questionário com orientações de educação financeira',
                'O governo não poderá ser responsabilizado se o empréstimo não for pago ao banco',
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
