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

class LoanAskPage extends JourneyStatefulWidget {
  const LoanAskPage({super.key}) : super(name: 'LoanAskPage');

  @override
  State<LoanAskPage> createState() => _LoanAskPageState();
}

class _LoanAskPageState extends State<LoanAskPage> {
  BannerAd? banner;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.loanAskStream,
        body: _body(context),
      ),
    );
  }

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.loanAskStream,
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
              const Text('Saiba como pedir o empr??stimo do Bolsa Fam??lia',
                  style: TextStyle(
                    color: AppColors.greenDark,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  )),
              const H(32),
              AppBannerAd(AdBannerStorage.loanAskStream),
              const H(32),
              Text(
                'Saiba como',
                style: AppTheme.title,
              ),
              const H(16),
              Text(
                'Voc?? pode contratar o emprestimo do Bolsa Fam??lia atrav??s de um dos canais abaixo.',
                style: AppTheme.subtitle,
              ),
              const H(24),
              _cardReceive1(),
              const H(16),
              _cardReceive2(),
              const H(16),
              _cardReceive3(),
              const H(32),
              const PrivacyPolicy(),
              const H(16),
            ],
          ),
        ),
      ],
    );
  }

  Container _cardReceive1() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFe6eaec),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'APP CAIXA TEM',
            style: AppTheme.title,
          ),
          _divisor(),
          Text(
            'Acesse o Caixa Tem e v?? em "Consignado Bolsa Fam??lia", depois em "Simular" e "Contratar"',
            style: AppTheme.subtitle,
          ),
          const H(16),
          Text(
            'Siga as orienta????es que aparecem na tela e conclua um novo pedido',
            style: AppTheme.subtitle,
          ),
        ],
      ),
    );
  }

  Container _cardReceive2() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFe6eaec),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'LOTERIAS CAIXA',
            style: AppTheme.title,
          ),
          _divisor(),
          Text(
            'V?? at?? uma ag??ncia lot??rica da CAIXA e apresente seu RG e CPF originais juntamente com o cart??o do Bolsa Fam??lia.',
            style: AppTheme.subtitle,
          ),
          const H(16),
          Text(
            'Informe ao atendente que deseja solicitar o emprestimo do Bolsa Fam??lia.',
            style: AppTheme.subtitle,
          ),
        ],
      ),
    );
  }

  Container _cardReceive3() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFe6eaec),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AG??NCIA CAIXA OU CORRESPONDENTE CAIXA AQUI',
            style: AppTheme.title,
          ),
          _divisor(),
          Text(
            'V?? at?? uma ag??ncia da CAIXA ou a um correspondente autorizado CAIXA Aqui e apresente seu RG, CPF originais e Comprovante de Resid??ncia  (Conta de ??gua, energia, telefone, etc).',
            style: AppTheme.subtitle,
          ),
          const H(16),
          Text(
            'Informe ao atendente que deseja solicitar o emprestimo do Bolsa Fam??lia.',
            style: AppTheme.subtitle,
          ),
        ],
      ),
    );
  }

  Padding _divisor() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 18),
      child: Divider(
        color: Color(0xFFd8dcde),
        thickness: 1.6,
        height: 0,
      ),
    );
  }
}
