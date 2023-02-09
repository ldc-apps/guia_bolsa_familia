import 'package:aid_brazil/app/ad/ad_banner_storage.dart';
import 'package:aid_brazil/app/components/app_banner_ad.dart';
import 'package:aid_brazil/app/components/app_card.dart';
import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/back.dart';
import 'package:aid_brazil/app/components/background_gradient.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/components/module_title.dart';
import 'package:aid_brazil/app/components/page_title.dart';
import 'package:aid_brazil/app/components/privacy_policy.dart';
import 'package:aid_brazil/app/components/stream_out.dart';
import 'package:aid_brazil/app/modules/new/new_controller.dart';
import 'package:aid_brazil/app/modules/new/new_model.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

import '../../../ad/ad_controller.dart';

class NewsPage extends JourneyStatefulWidget {
  const NewsPage({Key? key}) : super(key: key, name: 'NewsPage');

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewController _newController = NewController();
  BannerAd? banner;

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.newsStream,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.newsStream,
        body: bodyStacked(context),
      ),
    );
  }

  Widget bodyStacked(BuildContext _) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ContainerBackground(
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Back(
                onTap: () => AdController.showInterstitialAd(context),
              ),
              const H(8),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: PageTitle('Notícias',
                      'Fique sempre atualizado sobre programas sociais.'))
            ],
          ),
        ),
        const H(4),
        _body(context),
      ],
    );
  }

  Widget _body(BuildContext _) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            transform: Matrix4.translationValues(0, -90, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBannerAd(AdBannerStorage.newsStream),
                const H(32),
                const ModuleTitle(
                  'Últimas',
                  'Notícias',
                  boldBottom: true,
                ),
                const H(24),
                StreamOut<List<New>>(
                  stream: _newController.newsStream.listen,
                  child: (_, news) {
                    news.sort((a, b) => b.date!.compareTo(a.date!));
                    return Column(
                      children: news
                          .map((e) => AppCard(
                                title: e.title,
                                subtitle: DateFormat('dd/MM/yyyy hh:mm')
                                    .format(e.date!),
                                icon: Icons.open_in_new,
                                function: () async {
                                  await AdController.showInterstitialAd(
                                    _,
                                    onComplete: () => execUrl(e.url),
                                    pop: false,
                                  );
                                },
                              ))
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          ),
          const PrivacyPolicy()
        ],
      ),
    );
  }
}
