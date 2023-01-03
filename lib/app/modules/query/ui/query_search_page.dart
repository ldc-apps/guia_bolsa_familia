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
import 'package:aid_brazil/app/modules/search_nis/ui/search_nis_home_page.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/app_theme.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/back.dart';
import '../../../components/background_gradient.dart';

class QuerySearchPage extends StatefulWidget {
  const QuerySearchPage({Key? key}) : super(key: key);

  @override
  State<QuerySearchPage> createState() => _QuerySearchPageState();
}

class _QuerySearchPageState extends State<QuerySearchPage> {
  final QueryController _queryController = QueryController();
  final ScrollController _scrollController = ScrollController();

  BannerAd? banner;

  @override
  void initState() {
    _queryController.initQuerySearch();
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchQueryAd();
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.querySearchStream,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        onWillPop: () async => await AdController.showInterstitialAd(context),
        resizeAvoidBottom: false,
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.querySearchStream,
        body: bodyStacked(context));
  }

  Widget bodyStacked(_) {
    return StreamOut<QuerySearchCreate>(
      stream: _queryController.outQuerySearchCreate,
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

  Widget _topQuery(QuerySearchCreate create, BuildContext _) {
    return ContainerBackground(
      height: 446,
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
              const PageTitle('Consulta Rápida',
                  'Insira   abaixo   seu   NIS   e   toque   em   CONSULTAR.'),
              const H(36),
              const Text(
                'Digite seu NIS aqui.',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.white,
                ),
              ),
              const H(8),
              Field(
                controller: create.search,
                type: TextInputType.number,
                icon: Icons.help_outline,
                onTapIcon: () {
                  showDialog(
                      context: context, builder: (_) => _dialogNIS(context));
                },
                onChange: (v) {
                  create.search =
                      MaskedTextController(mask: '00000000000', text: v);
                  _queryController.inQuerySearchCreate.add(create);
                },
                label: empty,
                hint: '00000000000',
              ),
              const H(2),
              InkWell(
                onTap: () async {
                  create.save = !create.save;
                  _queryController.inQuerySearchCreate.add(create);
                  (await SharedPreferences.getInstance())
                      .setBool('save', create.save);
                },
                child: Container(
                  transform: Matrix4.translationValues(-6, 0, 0),
                  child: Row(
                    children: [
                      IgnorePointer(
                        ignoring: true,
                        child: Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          value: create.save,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          fillColor:
                              MaterialStateProperty.all(AppColors.greenLight),
                          onChanged: (v) {},
                        ),
                      ),
                      const W(2),
                      const Expanded(
                        child: Text(
                          'Salvar NIS',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const H(36),
              InkWell(
                onTap: () => _queryController.onSearchQuery(_),
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

  Widget _body(_, QuerySearchCreate create) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          AppBannerAd(AdBannerStorage.querySearchStream),
          const H(16),
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
