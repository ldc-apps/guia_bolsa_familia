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
import 'package:aid_brazil/app/utils/global_resources.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HowWorkWhatValuesPaidPage extends StatefulWidget {
  const HowWorkWhatValuesPaidPage({super.key});

  @override
  State<HowWorkWhatValuesPaidPage> createState() =>
      _HowWorkWhaValuesPaidsPageState();
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
                    '​Esses são os valores do Bolsa Família.',
                    style: AppTheme.subtitle,
                  ),
                  _divisor(),
                  ...[
                    'O valor normal do Bolsa Família é de R\$ 600 até o final do ano. Mas existem alguns outros benefícios complementares que permitem aumentar esse valor.',
                    'Alguns exemplos são famílias com crianças de até três anos, com mulheres grávidas ou lactantes, estudantes com bolsa de iniciação científica ou de esporte escolar, por exemplo.',
                    'Juntando todos os benefícios disponíveis, é possível receber até R\$ 1.220 por mês, se a família estiver dentro dos requisitos necessários.',
                  ].map((e) => labelItem(Icons.check, e)).toList(),
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
                  const H(16),
                  _cardReceive5(),
                  const H(16),
                  _cardReceive6(),
                  const H(32),
                  Text(
                    'Dá para receber todos os benefícios propostos no Bolsa Família?',
                    style: AppTheme.title,
                  ),
                  const H(16),
                  Text(
                    'O Ministério da Cidadania informou que a família pode receber todos os benefícios propostos pelo programa Bolsa Família, desde que preencha os pré-requisitos para receber.\n\nCaso a família preencha os requisitos para todos os benefícios, o valor total fica em R\$ 1.220 mensais (considerando que tenha pelo menos uma criança de até três anos e uma grávida, lactante ou pessoa entre três e 21 anos incompletos).\n\nÉ importante buscar um CRAS mais próximo de você para fazer parte de cada benefício do Bolsa Família, e também para saber se tem direito e quais benefícios tem direito receber.',
                    style: AppTheme.subtitle,
                  ),
                  const H(32),
                  Text(
                    'Participe!',
                    style: AppTheme.title,
                  ),
                  const H(16),
                  Text(
                    'Para saber se você tem direito ao Bolsa Família, participe do questionário do Bolsa Família.',
                    style: AppTheme.subtitle,
                  ),
                  const H(32),
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
            'BPI (Benefício Primeira Infância):',
            style: AppTheme.title,
          ),
          _divisor(),
          Text(
            'A família recebe mais R\$ 130 por criança de até três anos incompletos.',
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
            'BCF (Benefício de Composição Familiar)',
            style: AppTheme.title,
          ),
          _divisor(),
          Text(
            'O governo paga R\$ 65 a mais por pessoa se a família tiver gestantes, lactantes e/ou pessoas com idade entre três e 21 anos incompletos.\n\nAs lactantes recebem seis parcelas do benefício e as pessoas entre 18 e 21 anos incompletos precisam estar matriculadas na escola ou ter concluído a educação básica para ter direito ao benefício.',
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
            'BComp (Benefício Compensatório de Transição)',
            style: AppTheme.title,
          ),
          _divisor(),
          Text(
            'Esse benefício é pago para as famílias que recebiam um valor maior de Bolsa Família e, com a mudança do programa para o Bolsa Família, passou a receber menos dinheiro.\n\nO valor desse benefício pode variar dependendo da família.',
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
            'Bolsa de Iniciação Científica Júnior',
            style: AppTheme.title,
          ),
          _divisor(),
          Text(
            'Oque é?',
            style: AppTheme.subtitle.copyWith(fontWeight: FontWeight.bold),
          ),
          const H(16),
          Text(
            'Benefício pago para estudantes integrantes de famílias beneficiárias do Bolsa Família que tenham se destacado em competições acadêmicas e científicas nacionais.',
            style: AppTheme.subtitle,
          ),
          const H(16),
          Text(
            'Valor?',
            style: AppTheme.subtitle.copyWith(fontWeight: FontWeight.bold),
          ),
          const H(16),
          Text(
            '12 parcelas de R\$ 100 pagas ao estudante mais R\$ 1.000 pago em parcela única à família.',
            style: AppTheme.subtitle,
          ),
        ],
      ),
    );
  }

  Container _cardReceive5() {
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
            'Bolsa Família Inclusão Produtiva Rural',
            style: AppTheme.title,
          ),
          _divisor(),
          Text(
            'Oque é?',
            style: AppTheme.subtitle.copyWith(fontWeight: FontWeight.bold),
          ),
          const H(16),
          Text(
            'O benefício é pago para pessoas que vivem em zona rural em extrema vulnerabilidade, sem condições financeiras de investir em pequenas produções.',
            style: AppTheme.subtitle,
          ),
          const H(16),
          Text(
            'Valor?',
            style: AppTheme.subtitle.copyWith(fontWeight: FontWeight.bold),
          ),
          const H(16),
          Text(
            'São pagas parcelas mensais de R\$ 200 e só é autorizado um por família.',
            style: AppTheme.subtitle,
          ),
        ],
      ),
    );
  }

  Container _cardReceive6() {
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
            'Bolsa Família Esporte Escolar',
            style: AppTheme.title,
          ),
          _divisor(),
          Text(
            'Oque é?',
            style: AppTheme.subtitle.copyWith(fontWeight: FontWeight.bold),
          ),
          const H(16),
          Text(
            'Benefício pago a atletas escolares que tenham entre 12 e 17 anos incompletos.',
            style: AppTheme.subtitle,
          ),
          const H(16),
          Text(
            'Valor?',
            style: AppTheme.subtitle.copyWith(fontWeight: FontWeight.bold),
          ),
          const H(16),
          Text(
            '12 parcelas de R\$ 100 pagas ao estudante mais R\$ 1.000 pago em parcela única à família.',
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
