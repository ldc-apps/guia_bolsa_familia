import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../ad/ad_banner_storage.dart';
import '../../../ad/ad_controller.dart';
import '../../../components/app_banner_ad.dart';
import '../../../components/app_scaffold.dart';
import '../../../components/back.dart';
import '../../../components/back_share.dart';
import '../../../components/h.dart';
import '../../../components/privacy_policy.dart';
import '../../../components/w.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_theme.dart';

class LoanHowWorkPage extends JourneyStatefulWidget {
  const LoanHowWorkPage({super.key}) : super(name: 'LoanHowWorkPage');

  @override
  State<LoanHowWorkPage> createState() => _LoanHowWorkPageState();
}

class _LoanHowWorkPageState extends State<LoanHowWorkPage> {
  BannerAd? banner;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.loanHowWorkStream,
        body: _body(context),
      ),
    );
  }

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.loanHowWorkStream,
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
              const Text('Como funciona o empr??stimo do Bolsa Fam??lia',
                  style: TextStyle(
                    color: AppColors.greenDark,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  )),
              const H(16),
              Text(
                  'O empr??stimo Bolsa Fam??lia, tamb??m chamado de empr??stimo consignado Bolsa Fam??lia ou apenas Consignado Aux??lio, ?? um tipo de empr??stimo consignado.',
                  style: AppTheme.subtitle),
              const H(32),
              AppBannerAd(AdBannerStorage.loanHowWorkStream),
              const H(32),
              Text(
                'Entenda',
                style: AppTheme.title,
              ),
              const H(16),
              Text(
                'No empr??stimo consignado, o pagamento das parcelas ?? descontado diretamente do valor do benef??cio. Ou seja, n??o ?? preciso sacar ou transferir o valor da parcela ao banco, pois a quantia ?? debitada automaticamente do recebimento do aux??lio ou do BPC.',
                style: AppTheme.subtitle,
              ),
              _divisor(),
              ...[
                'A portaria publicada no Di??rio Oficial Uni??o (DOU) estabelece que a margem do empr??stimo ser?? de 5% do valor mensal do benef??cio.',
                'Importante: Quem desejar contratar o empr??stimo Bolsa Fam??lia ter?? como base para c??lculo o valor do benef??cio recebido.',
                'As parcelas para pagamento do consignado Bolsa Fam??lia ser??o descontadas mensalmente do benef??cio, de acordo com o prazo do contrato.',
                'O parcelamento pode ser feito em at?? 6 vezes.',
              ].map((e) => labelItem(e)).toList(),
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
