import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../ad/ad_banner_storage.dart';
import '../../../ad/ad_controller.dart';
import '../../../components/app_banner_ad.dart';
import '../../../components/app_scaffold.dart';
import '../../../components/back.dart';
import '../../../components/background_gradient.dart';
import '../../../components/divisor.dart';
import '../../../components/h.dart';
import '../../../components/module_title.dart';
import '../../../components/page_title.dart';
import '../../../components/privacy_policy.dart';
import '../../../components/quiz_loading_page.dart';
import '../../../components/w.dart';
import '../../../utils/app_colors.dart';
import '../../home/home_model.dart';
import '../../query/query_controller.dart';
import '../quiz_model.dart';

class QuizHomePage extends JourneyStatefulWidget {
  const QuizHomePage({Key? key}) : super(key: key, name: 'QuizHomePage');

  @override
  State<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  final QueryController _queryController = QueryController();
  final ScrollController _scrollController = ScrollController();

  BannerAd? banner;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        onWillPop: () async => await AdController.showInterstitialAd(context),
        resizeAvoidBottom: false,
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.quizHomeStream,
        body: _bodyStacked(context));
  }

  @override
  void initState() {
    _queryController.initQuerySearch();
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchQueryAd();
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.quizHomeStream,
    );
    super.initState();
  }

  Widget _body(_) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            transform: Matrix4.translationValues(0, -140, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBannerAd(AdBannerStorage.quizHomeStream),
                const H(64),
                const ModuleTitle('Canais de', 'Atendimento', boldBottom: true),
                const H(32),
                const Divisor(),
                for (var e in HomeItem.bottomItens(_))
                  _bottomHomeItem(context, e),
                const Divisor(),
                const H(32),
                Row(
                  children: [
                    _homeItem(_, HomeItem.itens(_)[0]),
                    const W(16),
                    _homeItem(_, HomeItem.itens(_)[1])
                  ],
                ),
              ],
            ),
          ),
          const PrivacyPolicy()
        ],
      ),
    );
  }

  Widget _bodyStacked(_) {
    return ListView(
      controller: _scrollController,
      padding: EdgeInsets.zero,
      children: [
        _topQuery(_),
        _body(_),
      ],
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
                      color: const Color(0xFFE45200),
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

  Widget _topQuery(BuildContext _) {
    return ContainerBackground(
      height: 530,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Back(
                margin: 0,
                onTap: () => AdController.showInterstitialAd(context),
              ),
              const H(36),
              const PageTitle('Você tem direito\nao Bolsa Família',
                  'Responda    a    este    questionário    rápido    e    saiba    se    você    está    ou    não    enquadrado(a)    nos    requisitos    do    programa    Bolsa Família    Brasil.'),
              const H(36),
              InkWell(
                onTap: () async {
                  await push(const QuizLoadingPage());
                  push(context, Quiz.initialize(context));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: AppColors.greenLight,
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: const [
                          Icon(
                            Icons.movie_outlined,
                            color: AppColors.greenDark,
                            size: 42,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              'AD',
                              style: TextStyle(
                                  color: AppColors.greenDark,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      const W(8),
                      const Text(
                        'COMEÇAR AGORA',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: AppColors.greenDark,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
