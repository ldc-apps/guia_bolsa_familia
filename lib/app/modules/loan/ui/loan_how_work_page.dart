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
              const Text('Como funciona o\nempréstimo do\nBolsa Família',
                  style: TextStyle(
                    color: AppColors.greenDark,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  )),
              const H(16),
              Text(
                  'O empréstimo Bolsa Família, também chamado de empréstimo consignado Bolsa Família ou apenas Consignado Bolsa Família, é um tipo de empréstimo consignado.',
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
                'No empréstimo consignado, o pagamento das parcelas é descontado diretamente do valor do benefício. Ou seja, não é preciso sacar ou transferir o valor da parcela ao banco, pois a quantia é debitada automaticamente do recebimento do Bolsa Família ou do BPC.',
                style: AppTheme.subtitle,
              ),
              _divisor(),
              ...[
                'A portaria publicada no Diário Oficial União (DOU) estabelece que a margem do empréstimo será de 40% do valor mensal do benefício.',
                'Importante: Quem desejar contratar o empréstimo Bolsa Família terá como base para cálculo o valor do benefício recebido.',
                'As parcelas para pagamento do consignado Bolsa Família serão descontadas mensalmente do benefício, de acordo com o prazo do contrato.',
                'O parcelamento pode ser feito em até 24 vezes.',
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
