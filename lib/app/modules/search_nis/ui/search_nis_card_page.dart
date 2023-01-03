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
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../components/privacy_policy.dart';

class SearchNisCardPage extends StatefulWidget {
  const SearchNisCardPage({super.key});

  @override
  State<SearchNisCardPage> createState() => _SearchNisCardPageState();
}

class _SearchNisCardPageState extends State<SearchNisCardPage> {
  BannerAd? banner;

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.searchNisCardStream,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.searchNisCardStream,
        body: _body(context),
      ),
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
              ),
              const H(32),
              const Text('Consultar NIS\nno CARTÃO CIDADÃO',
                  style: TextStyle(
                    color: AppColors.greenDark,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  )),
              const H(32),
              const Text(
                  'Primeiramente, é válido destacar que o número do NIS é encontrado de maneira simples na parte frontal do Cartão Cidadão.',
                  style: TextStyle(color: AppColors.greenDark, fontSize: 18)),
              const H(24),
              AppBannerAd(AdBannerStorage.searchNisCardStream),
              const H(32),
              Text(
                'Como consultar',
                style: AppTheme.title,
              ),
              const H(16),
              Text(
                'A numeração que está impressa é a mesma que compõe o número do NIS. Então, caso você tenha esse cartão em mãos, basta checar a numeração, que é o número do NIS, que consta na parte frontal.',
                style: AppTheme.subtitle,
              ),
              const H(16),
              ClipRRect(
                child: CachedNetworkImage(
                  imageUrl:
                      'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg',
                  placeholder: (context, url) => const Loading(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                  height: 280,
                ),
              ),
              _divisor(),
              const H(16),
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
