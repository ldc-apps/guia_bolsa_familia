import 'package:aid_brazil/app/ad/ad_banner_storage.dart';
import 'package:aid_brazil/app/ad/ad_controller.dart';
import 'package:aid_brazil/app/components/app_banner_ad.dart';
import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/back.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/components/loading.dart';
import 'package:aid_brazil/app/components/w.dart';
import 'package:aid_brazil/app/modules/search_nis/search_nis_model.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../components/privacy_policy.dart';

class SearchNisPhonePage extends StatefulWidget {
  const SearchNisPhonePage({super.key});

  @override
  State<SearchNisPhonePage> createState() => _SearchNisPhonePageState();
}

class _SearchNisPhonePageState extends State<SearchNisPhonePage> {
  BannerAd? banner;

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.searchNisPhoneStream,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.searchNisPhoneStream,
        body: _body(context),
      ),
    );
  }

  Widget _body(_) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const H(16),
            Back(
              onTap: () => AdController.showInterstitialAd(context),
              color: AppColors.greenDark,
              margin: 0,
            ),
            const H(32),
            const Text('Consultar NIS\npelo TELEFONE INSS',
                style: TextStyle(
                  color: AppColors.greenDark,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                )),
            const H(32),
            const Text(
                'É possível consultar o número do PIS pelo telefone do INSS',
                style: TextStyle(color: AppColors.greenDark, fontSize: 18)),
            const H(24),
            AppBannerAd(AdBannerStorage.searchNisPhoneStream),
            const H(32),
            Text(
              'Como consultar',
              style: AppTheme.title,
            ),
            const H(16),
            Text(
              'Ligue para o INSS por telefone FIXO ou CELULAR,',
              style: AppTheme.subtitle,
            ),
            _divisor(),
            const H(16),
            _inssPhoneBox(),
            const H(36),
            const PrivacyPolicy(),
            const H(96),
          ],
        ),
        _bottomButton(),
      ],
    );
  }

  Container _inssPhoneBox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColors.grey, borderRadius: BorderRadius.circular(16)),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('INSS', style: AppTheme.title),
          const H(6),
          Row(
            children: [
              const Icon(
                Icons.headset_mic_outlined,
                color: AppColors.green,
              ),
              const W(8),
              Text(
                '135',
                style: AppTheme.subtitle.copyWith(color: AppColors.green),
              ),
            ],
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1.6,
            height: 40,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(
                  Icons.attach_email,
                  color: AppColors.green,
                ),
              ),
              const W(8),
              Expanded(
                child: Text(
                  'O  atendimento  da  central  funciona  das  07h  às  22h,  de  segunda-feira  a  sábado,  conforme  horário de Brasília.',
                  style: AppTheme.subtitle.copyWith(height: 1.4),
                ),
              )
            ],
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1.6,
            height: 40,
          ),
          _callButton()
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

  Widget itemStep(BuildContext context, SearchNisStep step) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: AppColors.greenDark,
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(step.position.toString(),
                style: AppTheme.title.copyWith(color: AppColors.white)),
          ),
        ),
        const H(16),
        Text(
          step.title,
          style: AppTheme.subtitle,
        ),
        if (step.url != null) const H(16),
        if (step.url != null)
          ClipRRect(
            child: CachedNetworkImage(
              imageUrl: step.url!,
              placeholder: (context, url) => const Loading(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: 280,
            ),
          )
      ],
    );
  }

  Widget _callButton() {
    return InkWell(
      onTap: () => launchUrlString("tel://135"),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.green,
        ),
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            W(24),
            Text(
              'LIGAR AGORA',
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900),
            ),
            W(16),
            Icon(
              Icons.call,
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
            color: AppColors.greenDark,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )),
        padding: const EdgeInsets.all(20),
        child: InkWell(
          onTap: () async {
            await AdController.showInterstitialAd(
              context,
              onComplete: () => launchUrlString("tel://135"),
              pop: false,
            );
          },
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.greenLight,
            ),
            width: double.maxFinite,
            child: Stack(
              children: const [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'LIGAR AGORA',
                    style: TextStyle(
                        color: AppColors.greenDark,
                        fontSize: 18,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.open_in_new,
                    color: AppColors.greenDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
