import 'package:aid_brazil/app/ad/ad_banner_storage.dart';
import 'package:aid_brazil/app/components/app_banner_ad.dart';
import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/back.dart';
import 'package:aid_brazil/app/components/background_gradient.dart';
import 'package:aid_brazil/app/components/divisor.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/components/module_title.dart';
import 'package:aid_brazil/app/components/privacy_policy.dart';
import 'package:aid_brazil/app/components/w.dart';
import 'package:aid_brazil/app/modules/home/home_model.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/app_theme.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../ad/ad_controller.dart';

class SearchNisOptionsPage extends JourneyStatefulWidget {
  final String title;
  final String subTitle;

  const SearchNisOptionsPage(this.title, this.subTitle, {Key? key})
      : super(key: key, name: 'SearchNisOptionsPage') ;

  @override
  State<SearchNisOptionsPage> createState() => _SearchNisOptionsPageState();
}

class _SearchNisOptionsPageState extends State<SearchNisOptionsPage> {
  BannerAd? banner;

  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.nisOptionsStream,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      active: AdController.adConfig.banner.active,
      behavior: AdBannerStorage.nisOptionsStream,
      body: bodyStacked(context),
    );
  }

  ListView bodyStacked(context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ContainerBackground(
          height: 260,
          child: Column(
            children: [
              _backButton(context),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ops... 😇',
                      style: AppTheme.title
                          .copyWith(color: AppColors.white, fontSize: 32),
                    ),
                    const H(8),
                    Text(
                      'Não encontramos suas informações em nossa base da dados. Confira abaixo, alternativas para consultar seu NIS.',
                      style:
                          AppTheme.subtitle.copyWith(color: Colors.grey[400]),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body(context),
      ],
    );
  }

  Widget body(_) {
    return Column(
      children: [
        Container(
          transform: Matrix4.translationValues(0, -40, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: AppBannerAd(AdBannerStorage.nisOptionsStream)),
              const H(24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ModuleTitle('Canais de', 'Atendimento',
                        boldBottom: true),
                    const H(24),
                    const Divisor(),
                    for (var e in HomeItem.bottomItens(_))
                      _bottomHomeItem(context, e),
                    const H(24),
                    Row(
                      children: [
                        _homeItem(_, HomeItem.itens(_)[2]),
                        const W(16),
                        _homeItem(_, HomeItem.itens(_)[1])
                      ],
                    ),
                    const H(16),
                  ],
                ),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: PrivacyPolicy(),
        )
      ],
    );
  }

  Widget _homeItem(_, HomeItem item) {
    return Expanded(
      child: InkWell(
        onTap: item.function,
        child: Container(
          height: 160,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item.icon,
                size: 84,
                color: AppColors.green,
              ),
              const H(16),
              Text(
                item.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.green,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _backButton(context) {
    return Back(
      onTap: () async => await AdController.showInterstitialAd(context),
      label: 'Voltar',
      action: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF032133),
        ),
        child: Row(
          children: const [
            Icon(
              Icons.share_outlined,
              size: 18,
              color: AppColors.greenLight,
            ),
            W(8),
            Text(
              'Compartilhar',
              style: TextStyle(color: AppColors.white, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }

  Widget _bottomHomeItem(BuildContext context, HomeItem item) {
    return Column(
      children: [
        InkWell(
          onTap: item.function,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                const W(8),
                Icon(
                  item.icon,
                  color: AppColors.greenDark,
                  size: 52,
                ),
                const W(16),
                Expanded(
                    child: Text(
                  item.label,
                  style: const TextStyle(
                      color: AppColors.greenDark,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                )),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(4)),
                  child: Icon(
                    item.action,
                    color: AppColors.white,
                    size: 16,
                  ),
                )
              ],
            ),
          ),
        ),
        const Divisor()
      ],
    );
  }
}
