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

class HowRegisterReceivePage extends JourneyStatefulWidget {
  const HowRegisterReceivePage({super.key}) : super(name: 'HowRegisterReceivePage');

  @override
  State<HowRegisterReceivePage> createState() => _HowRegisteReceiveoPageState();
}

class _HowRegisteReceiveoPageState extends State<HowRegisterReceivePage> {
  BannerAd? banner;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.howRegisterReceiveStream,
        body: _body(context),
      ),
    );
  }

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.howRegisterReceiveStream,
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
              const Text('Receba seu Bolsa Fam??lia',
                  style: TextStyle(
                    color: AppColors.greenDark,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  )),
              const H(16),
              Text('Veja as melhores formas de receber seu Bolsa Fam??lia!',
                  style: AppTheme.subtitle),
              const H(32),
              AppBannerAd(AdBannerStorage.howRegisterReceiveStream),
              const H(32),
              Text(
                'Saiba como',
                style: AppTheme.title,
              ),
              const H(16),
              Text(
                '???O pagamento do Bolsa Fam??lia ?? realizado mensalmente pela CAIXA, conforme calend??rio de pagamentos. ',
                style: AppTheme.subtitle,
              ),
              const H(16),
              Text(
                'O pagamento pode ser realizado das seguintes formas:',
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
            'POUPAN??A SOCIAL DIGITAL',
            style: AppTheme.title,
          ),
          _divisor(),
          Text(
            'A Conta Poupan??a Social Digital ?? uma poupan??a simplificada aberta automaticamente em nome dos respons??veis pela fam??lia, sem necessidade de solicita????o ou comparecimento a uma ag??ncia da CAIXA.',
            style: AppTheme.subtitle,
          ),
          _divisor(),
          Text(
            'A conta pode ser acessada pelo aplicativo CAIXA Tem para realizar compras com o cart??o de d??bito virtual, pagamento de boletos, contas de ??gua, luz e telefone, fazer transfer??ncias, saques sem cart??o nos caixas eletr??nicos e nas lot??ricas.',
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
            'POUPAN??A CAIXA F??CIL',
            style: AppTheme.title,
          ),
          _divisor(),
          Text(
            'A Poupan??a CAIXA F??cil ?? uma conta simplificada, com limite de saldo e movimenta????o mensal de R\$ 3.000,00. A conta possui um cart??o magn??tico que possibilita compras, dep??sitos, saldos, transfer??ncias e muito mais.',
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
            'SAQUE COM CART??O DO PROGRAMA',
            style: AppTheme.title,
          ),
          _divisor(),
          Text(
            'Com o cart??o ?? poss??vel realizar o saque nos terminais de autoatendimento da CAIXA, nos correspondentes CAIXA Aqui e nas unidades Lot??ricas.',
            style: AppTheme.subtitle,
          ),
          _divisor(),
          Text(
            'Para realizar o saque nos correspondentes CAIXA Aqui e nas unidades Lot??ricas, ?? necess??rio apresentar um documento de identifica????o e o cart??o do benef??cio.',
            style: AppTheme.subtitle,
          ),
          _divisor(),
          Text(
            'O cart??o ?? enviado para o endere??o informado no Cadastro ??nico quando da inclus??o da fam??lia no Programa.',
            style: AppTheme.subtitle.copyWith(fontWeight: FontWeight.w900),
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
