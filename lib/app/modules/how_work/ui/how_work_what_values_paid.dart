import 'package:aid_brazil/app/ad/ad_banner_storage.dart';
import 'package:aid_brazil/app/ad/ad_controller.dart';
import 'package:aid_brazil/app/components/app_banner_ad.dart';
import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/back.dart';
import 'package:aid_brazil/app/components/back_share.dart';
import 'package:aid_brazil/app/components/bottom_button.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/components/privacy_policy.dart';
import 'package:aid_brazil/app/components/w.dart';
import 'package:aid_brazil/app/modules/quiz/ui/quiz_home_page.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/app_theme.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HowWorkWhatValuesPaidPage extends JourneyStatefulWidget {
  const HowWorkWhatValuesPaidPage({super.key}) : super(name: 'HowWorkWhatValuesPaidPage');

  @override
  State<HowWorkWhatValuesPaidPage> createState() => _HowWorkWhaValuesPaidsPageState();
}

class _HowWorkWhaValuesPaidsPageState extends State<HowWorkWhatValuesPaidPage> {
  BannerAd? banner;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.howWorkWhatValuesPaidStream,
        body: _body(context),
      ),
    );
  }

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.howWorkWhatValuesPaidStream,
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
                  const Text('Quais valores são pagos',
                      style: TextStyle(
                        color: AppColors.greenDark,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      )),
                  const H(16),
                  Text(
                    'Esses são os valores que você pode receber no Bolsa Família',
                    style: AppTheme.subtitle,
                  ),
                  const H(32),
                  AppBannerAd(AdBannerStorage.howWorkWhatValuesPaidStream),
                  const H(32),
                  Text(
                    'Entenda',
                    style: AppTheme.title,
                  ),
                  const H(16),
                  Text(
                    'Famílias elegíveis irão migrar automaticamente do Auxílio Brasil para o Bolsa Família, sem necessidade de realizar novo cadastro.\n\nO novo Bolsa Família começa a ser pago pela Caixa Econômica Federal a partir do dia 20 de março. O programa, que substitui o Auxílio Brasil, foi lançado na quinta-feira (2) pelo presidente Luiz Inácio Lula da Silva (PT), e atende famílias em situação de pobreza ou extrema pobreza.\n\nO benefício será de, no mínimo, R\$ 600 por família. O programa ainda conta com novos acréscimos: são mais R\$ 150 por criança de até seis anos e, a partir de junho, um adicional de R\$ 50 por integrante entre 7 e 18 anos incompletos e mulheres gestantes cadastradas na família.',
                    style: AppTheme.subtitle,
                  ),
                  const H(16),
                  Text(
                    'Benefícios',
                    style: AppTheme.title,
                  ),
                  const H(16),
                  Text(
                    'Veja aqui os beneficios que complementam Bolsa Família.',
                    style: AppTheme.subtitle,
                  ),
                  const H(32),
                  _cardReceive1(),
                  const H(16),
                  _cardReceive2(),
                  const H(16),
                  _cardReceive3(),
                  const H(16),
                  _cardReceive4(),
                  const H(32),
                  Text(
                    'Dá para receber todos os benefícios propostos no Bolsa Família?',
                    style: AppTheme.title,
                  ),
                  const H(16),
                  Text(
                    'O Ministério da Cidadania informou que a família pode receber todos os benefícios propostos pelo programa Bolsa Família, desde que preencha os pré-requisitos para receber.\n\nÉ importante buscar um CRAS mais próximo de você para fazer parte de cada benefício do Bolsa Família, e também para saber se tem direito e quais benefícios tem direito receber.',
                    style: AppTheme.subtitle,
                  ),
                  const H(64),
                  const PrivacyPolicy(),
                  const H(96),
                ],
              ),
            ),
          ],
        ),
        BottomButton('SAIBA SE VOCÊ TEM DIREITO', Icons.rule, () {
          Navigator.pop(context);
          Navigator.pop(context);
          push(context, const QuizHomePage());
        })
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
            'Benefício de Renda de Cidadania:',
            style: AppTheme.title,
          ),
          _divisor(),
          Text(
            'Pago para todos os integrantes da família, no valor de R\$ 142 por pessoa.',
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
            'Benefício Complementar:',
            style: AppTheme.title,
          ),
          _divisor(),
          Text(
            'pago às famílias beneficiárias do Programa Bolsa Família, caso o Benefício de Renda de Cidadania não seja o suficiente para alcançar o valor mínimo de R\$600 por família. O complemento é calculado para garantir que nenhuma família receba menos que o valor de R\$ 600;',
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
            'Benefício Primeira Infância:',
            style: AppTheme.title,
          ),
          _divisor(),
          Text(
            'no valor de R\$ 150 por criança com idade entre 0 (zero) e 6 anos;',
            style: AppTheme.subtitle,
          ),
        ],
      ),
    );
  }

  Container _cardReceive4() {
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
            'Benefício Variável Familiar:',
            style: AppTheme.title,
          ),
          _divisor(),
          Text(
            'Pago às famílias que tenham em sua composição gestantes e/ou crianças, com idade entre 7 (sete) e 12 (doze) anos incompletos e/ou adolescentes, com idade entre 12 (doze) e 18 (dezoito) anos incompletos; no valor de R\$ 50 por pessoa que atenda estes critérios.',
            style: AppTheme.subtitle,
          ),
        ],
      ),
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
