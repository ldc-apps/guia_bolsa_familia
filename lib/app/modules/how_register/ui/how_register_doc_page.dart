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

class HowRegisterDocPage extends JourneyStatefulWidget {
  const HowRegisterDocPage({super.key}) : super(name: 'HowRegisterDocPage');

  @override
  State<HowRegisterDocPage> createState() => _HowRegisterDocPageState();
}

class _HowRegisterDocPageState extends State<HowRegisterDocPage> {
  BannerAd? banner;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.howRegisterDocStream,
        body: _body(context),
      ),
    );
  }

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.howRegisterDocStream,
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
              const Text('Documentos\nnecessários',
                  style: TextStyle(
                    color: AppColors.greenDark,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  )),
              const H(16),
              Text(
                  'Esses são todos os documentos que você precisa para se cadastrar no Bolsa Família.',
                  style: AppTheme.subtitle),
              const H(32),
              AppBannerAd(AdBannerStorage.howRegisterDocStream),
              const H(32),
              Text(
                'Documentos',
                style: AppTheme.title,
              ),
              const H(16),
              Text(
                '​Você deve ter em mãos os seguintes documentos:',
                style: AppTheme.subtitle,
              ),
              _divisor(),
              ...[
                'Certidão de nascimento',
                'Comprovante de residência',
                'Certidão de casamento - caso seja casado(a).',
                'CPF',
                'RG',
                'Carteira de trabalho',
                'Título de eleitor',
                'Registro Administrativo de nascimento indígina (RANI) No caso se a pessoa for indígina.',
              ].map((e) => labelItem(e)).toList(),
              const H(8),
              Text(
                  'Agora com esses documentos você já pode fazer seu cadastro no CadÚnico, para saber mais detalhes, volte e acesse os próximos passos.',
                  style: AppTheme.subtitle),
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
