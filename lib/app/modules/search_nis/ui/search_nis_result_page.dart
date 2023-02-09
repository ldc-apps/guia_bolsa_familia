import 'package:aid_brazil/app/ad/ad_banner_storage.dart';
import 'package:aid_brazil/app/ad/ad_controller.dart';
import 'package:aid_brazil/app/components/app_banner_ad.dart';
import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/field.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/components/loading.dart';
import 'package:aid_brazil/app/components/page_title.dart';
import 'package:aid_brazil/app/components/privacy_policy.dart';
import 'package:aid_brazil/app/components/stream_out.dart';
import 'package:aid_brazil/app/components/w.dart';
import 'package:aid_brazil/app/modules/home/home_model.dart';
import 'package:aid_brazil/app/modules/query/query_controller.dart';
import 'package:aid_brazil/app/modules/query/query_model.dart';
import 'package:aid_brazil/app/modules/search_nis/search_nis_controller.dart';
import 'package:aid_brazil/app/modules/search_nis/search_nis_model.dart';
import 'package:aid_brazil/app/modules/search_nis/ui/search_nis_home_page.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/app_theme.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../components/back.dart';
import '../../../components/background_gradient.dart';

class SearchNisResultPage extends JourneyStatefulWidget {
  final QueryResult result;

  const SearchNisResultPage(this.result, {Key? key}) : super(key: key, name: 'SearchNisResultPage');

  @override
  State<SearchNisResultPage> createState() => _SearchNisResultPageState();
}

class _SearchNisResultPageState extends State<SearchNisResultPage> {
  final NisController _nisController = NisController();
  final ScrollController _scrollController = ScrollController();
  final QueryController _quaryController = QueryController();

  BannerAd? banner;

  @override
  void initState() {
    _nisController.initNisSearch();
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchQueryAd();
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.nisResultStream,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        onWillPop: () async => await AdController.showInterstitialAd(context),
        resizeAvoidBottom: false,
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.nisResultStream,
        body: bodyStacked(context));
  }

  Widget bodyStacked(_) {
    return StreamOut<NisSearchCreate>(
      stream: _nisController.outNisSearchCreate,
      child: (_, create) => ListView(
        controller: _scrollController,
        padding: EdgeInsets.zero,
        children: [
          _topQuery(create, _),
          _body(context, create),
        ],
      ),
    );
  }

  Widget _topQuery(NisSearchCreate create, BuildContext _) {
    return ContainerBackground(
      height: 400,
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
              PageTitle('Olá, ${widget.result.name.split(' ').first}.',
                  'Encontramos seu NIS! Salve seu NIS disponível abaixo em um local seguro!'),
              const H(36),
              const Text(
                'Digite seu CPF aqui.',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.white,
                ),
              ),
              const H(8),
              InkWell(
                onTap: () => copyClipboard(widget.result.nis),
                child: IgnorePointer(
                  ignoring: true,
                  child: Field(
                    controller: TextEditingController(text: widget.result.nis),
                    type: TextInputType.number,
                    icon: Icons.copy,
                    onChange: (v) =>
                        _nisController.inNisSearchCreate.add(create),
                    label: empty,
                    hint: '000.000.000-00',
                  ),
                ),
              ),
              const H(16),
              InkWell(
                onTap: () async {
                  await _quaryController.initQuerySearch();
                  _quaryController.querySearchCreate.search.text =
                      widget.result.nis;
                  _quaryController.querySearchCreate.save = true;
                  _quaryController.onSearchQuery(context);
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
                        'CONSULTAR BENEFÍCIO',
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

  Widget _body(_, NisSearchCreate create) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          AppBannerAd(AdBannerStorage.nisResultStream),
          const H(16),
          Row(
            children: [
              _homeItem(_, HomeItem.itens(_)[2]),
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

  Widget _dialogNIS(BuildContext context) {
    return SimpleDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      children: [
        Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://ldcapps.com/wp-content/uploads/2022/11/mulher-segurando-cartao-auxilio-brasil.jpg',
                    placeholder: (context, url) => const Loading(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.fill,
                  ),
                )),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.cancel_outlined,
                    color: AppColors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Oque é NIS?',
                style: AppTheme.title,
              ),
              const H(24),
              Text(
                  'O Número de Identificação Social (NIS) é um cadastro oferecido pelo Governo Federal para identificar o cidadão que recebe ou não benefício social. ',
                  style: AppTheme.subtitle.copyWith(fontSize: 18)),
              const H(24),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            push(context, const SearchNisHomePage());
          },
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppColors.greenLight,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Aprenda como consultar\nseu NIS',
                    style: AppTheme.title.copyWith(fontSize: 18),
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                      color: AppColors.greenDark,
                      borderRadius: BorderRadius.circular(4)),
                  child: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AppColors.greenLight,
                    size: 24,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
