import 'package:aid_brazil/app/ad/ad_banner_storage.dart';
import 'package:aid_brazil/app/ad/ad_controller.dart';
import 'package:aid_brazil/app/components/app_banner_ad.dart';
import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/back.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/components/loading.dart';
import 'package:aid_brazil/app/modules/search_nis/search_nis_model.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/app_theme.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../components/privacy_policy.dart';

class SearchNisInssPage extends JourneyStatefulWidget {
  const SearchNisInssPage({super.key}) : super(name: 'SearchNisInssPage');

  @override
  State<SearchNisInssPage> createState() => _SearchNisInssPageState();
}

class _SearchNisInssPageState extends State<SearchNisInssPage> {
  BannerAd? banner;

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.searchNisInssStream,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.searchNisInssStream,
        body: _body(context),
      ),
    );
  }

  Widget _body(_) {
    return Stack(
      children: [
        SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const H(16),
              Back(
                onTap: () => AdController.showInterstitialAd(context),
                color: AppColors.greenDark,
                margin: 0,
              ),
              const H(32),
              const Text('Consultar NIS pelo\nSITE MEU INSS',
                  style: TextStyle(
                    color: AppColors.greenDark,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  )),
              const H(32),
              const Text(
                  'Pelo site Meu INSS ?? poss??vel tamb??m consultar o n??mero do NIS pelo CPF. Para isso, caso voc?? tenha o cadastro, basta seguir o passo a passo:',
                  style: TextStyle(color: AppColors.greenDark, fontSize: 18)),
              const H(24),
              AppBannerAd(AdBannerStorage.searchNisInssStream),
              const H(32),
              Text(
                'Como consultar',
                style: AppTheme.title,
              ),
              const H(16),
              Text(
                'Aprenda como consultar seu NIS\natrav??s do site Meu INSS',
                style: AppTheme.subtitle,
              ),
              _divisor(),
              itemStep(context, SearchNisStep.itensNIS[0]),
              _divisor(),
              itemStep(context, SearchNisStep.itensNIS[1]),
              _divisor(),
              itemStep(context, SearchNisStep.itensNIS[2]),
              _divisor(),
              itemStep(context, SearchNisStep.itensNIS[3]),
              _divisor(),
              itemStep(context, SearchNisStep.itensNIS[4]),
              _divisor(),
              itemStep(context, SearchNisStep.itensNIS[5]),
              _divisor(),
              itemStep(context, SearchNisStep.itensNIS[6]),
              _divisor(),
              const H(32),
              const PrivacyPolicy(),
              const H(96),
            ],
          ),
        ),
        _bottomButton()
      ],
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
              onComplete: () => execUrl('https://meu.inss.gov.br/#/login'),
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
                    'ACESSAR SITE MEU INSS',
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
}
