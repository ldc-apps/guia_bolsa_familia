import 'package:aid_brazil/app/ad/ad_banner_storage.dart';
import 'package:aid_brazil/app/ad/ad_controller.dart';
import 'package:aid_brazil/app/components/app_banner_ad.dart';
import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/components/how_register_loading_page.dart';
import 'package:aid_brazil/app/components/page_title.dart';
import 'package:aid_brazil/app/components/privacy_policy.dart';
import 'package:aid_brazil/app/components/w.dart';
import 'package:aid_brazil/app/modules/home/home_model.dart';
import 'package:aid_brazil/app/modules/how_register/ui/how_register_home_page.dart';
import 'package:aid_brazil/app/modules/query/query_controller.dart';
import 'package:aid_brazil/app/modules/quiz/ui/quiz_home_page.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../components/back.dart';
import '../../../components/background_gradient.dart';

class QuizSuccessPage extends JourneyStatefulWidget {
  const QuizSuccessPage({Key? key}) : super(key: key, name: 'QuizSuccessPage');

  @override
  State<QuizSuccessPage> createState() => _QuizSuccessPageState();
}

class _QuizSuccessPageState extends State<QuizSuccessPage> {
  final QueryController _queryController = QueryController();
  final ScrollController _scrollController = ScrollController();

  BannerAd? banner;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        onWillPop: () async =>
            await AdController.pushReplaceAndShowIntersticial(
                context, const QuizHomePage()),
        resizeAvoidBottom: false,
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.quizSuccessStream,
        body: _bodyStacked(context));
  }

  @override
  void initState() {
    _queryController.initQuerySearch();
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchQueryAd();
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.quizSuccessStream,
    );
    super.initState();
  }

  Widget _body(_) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          AppBannerAd(AdBannerStorage.quizSuccessStream),
          const H(64),
          Row(
            children: [
              _homeItem(_, HomeItem.itens(_)[0]),
              const W(16),
              _homeItem(_, HomeItem.itens(_)[1])
            ],
          ),
          const H(32),
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
      height: 350,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Back(
                margin: 0,
                onTap: () => AdController.pushReplaceAndShowIntersticial(
                    context, const QuizHomePage()),
              ),
              const H(36),
              const PageTitle('Parabéns 🎉',
                  'Identificamos que você se enquadra como beneficiário do Bolsa Família, saiba como fazer para se cadastrar no Bolsa Família clicando no botão abaixo.'),
              const H(36),
              InkWell(
                onTap: () async {
                  await push(const HowRegisterLoadingPage());
                  await AdController.pushReplaceAndShowIntersticial(
                      context, const HowRegisterHomePage());
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
                        'COMO SE CADASTRAR',
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
