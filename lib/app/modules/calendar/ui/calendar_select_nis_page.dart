import 'package:aid_brazil/app/ad/ad_banner_storage.dart';
import 'package:aid_brazil/app/ad/ad_controller.dart';
import 'package:aid_brazil/app/components/app_banner_ad.dart';
import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/back.dart';
import 'package:aid_brazil/app/components/background_gradient.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/components/page_title.dart';
import 'package:aid_brazil/app/components/privacy_policy.dart';
import 'package:aid_brazil/app/components/w.dart';
import 'package:aid_brazil/app/modules/calendar/calendar_controller.dart';
import 'package:aid_brazil/app/modules/calendar/ui/calendar_payment_day_page.dart';
import 'package:aid_brazil/app/modules/home/home_model.dart';
import 'package:aid_brazil/app/modules/search_nis/ui/search_nis_home_page.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/app_theme.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CalendarSelectNisPage extends JourneyStatefulWidget {
  const CalendarSelectNisPage({Key? key}) : super(key: key, name: 'CalendarSelectNisPage');

  @override
  State<CalendarSelectNisPage> createState() => _CalendarSelectNisPageState();
}

class _CalendarSelectNisPageState extends State<CalendarSelectNisPage> {
  final CalendarController _calendarController = CalendarController();
  final ScrollController _scrollController = ScrollController();

  BannerAd? banner;

  Widget bodyStacked(_) {
    return ListView(
      controller: _scrollController,
      padding: EdgeInsets.zero,
      children: [
        _topQuery(_),
        _body(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        onWillPop: () async => await AdController.showInterstitialAd(context),
        resizeAvoidBottom: false,
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.calendarSelectNisStream,
        body: bodyStacked(context));
  }

  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.calendarSelectNisStream,
    );
    super.initState();
  }

  Widget _body(_) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          AppBannerAd(AdBannerStorage.calendarSelectNisStream),
          const H(16),
          Row(
            children: [
              _homeItem(_, HomeItem.itens(_)[0]),
              const W(16),
              _homeItem(_, HomeItem.itens(_)[2])
            ],
          ),
          const H(32),
          const PrivacyPolicy()
        ],
      ),
    );
  }

  Widget _dialogNIS(BuildContext context) {
    return SimpleDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      children: [
        Align(
          alignment: Alignment.centerRight,
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
        Row(
          children: const [
            W(16),
            Icon(
              Icons.swipe_outlined,
              color: AppColors.greenDark,
            ),
            W(16),
            Text(
              'Arraste para os lados',
              style: TextStyle(color: AppColors.greenDark, fontSize: 18),
            )
          ],
        ),
        const H(16),
        SizedBox(
          width: double.maxFinite,
          height: 120,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const W(16),
                ClipRRect(
                  child: Container(
                    width: 190,
                    height: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                            fit: BoxFit.fill,
                            image: CachedNetworkImageProvider(
                                'https://ldcapps.com/wp-content/uploads/2022/11/auxilio-brasil.png'))),
                  ),
                ),
                const W(8),
                ClipRRect(
                  child: Container(
                    width: 190,
                    height: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                            fit: BoxFit.fill,
                            image: CachedNetworkImageProvider(
                                'https://ldcapps.com/wp-content/uploads/2022/11/cartao-cidadao.png'))),
                  ),
                ),
                const W(8),
                ClipRRect(
                  child: Container(
                    width: 190,
                    height: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                            fit: BoxFit.fill,
                            image: CachedNetworkImageProvider(
                                'https://ldcapps.com/wp-content/uploads/2022/11/bolsa-familia.png'))),
                  ),
                ),
                const W(16),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Encontre o NIS em seu cartão do Bolsa Família',
                style: AppTheme.title,
              ),
              const H(24),
              Text(
                  'Na parte inferior do seu cartão está impresso o número do NIS.',
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

  Widget _itemNumber(_, int value) {
    return InkWell(
      onTap: () {
        final days = _calendarController.getDaysInYear(value);
        final day = _calendarController.getCurrentDay(days);
        push(
            _,
            CalendarPaymentDay(value, days, day,
                [1, 2, 3, 4, 5, 6].contains(day.month) ? 0 : 1));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.greenLight,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Text(
            value.toString(),
            style: const TextStyle(
                color: AppColors.greenDark,
                fontWeight: FontWeight.w900,
                fontSize: 64),
          ),
        ),
      ),
    );
  }

  Widget _keyboardNumber(_) {
    return StaggeredGrid.count(
      axisDirection: AxisDirection.down,
      crossAxisCount: 3,
      mainAxisSpacing: 24,
      crossAxisSpacing: 24,
      children: [1, 2, 3, 4, 5, 6, 7, 8, 9, null, 0, null]
          .map((e) => e == null
              ? const SizedBox()
              : StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: _itemNumber(_, e),
                ))
          .toList(),
    );
  }

  Widget _topQuery(BuildContext _) {
    return ContainerBackground(
      height: 750,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Back(
              margin: 0,
              onTap: () => AdController.showInterstitialAd(context),
              action: InkWell(
                onTap: () => showDialog(
                    context: context, builder: (_) => _dialogNIS(context)),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFF0A4A08),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.help_outline,
                        size: 18,
                        color: AppColors.greenLight,
                      ),
                      W(8),
                      Text(
                        'Ajuda',
                        style: TextStyle(color: AppColors.white, fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const H(36),
            const PageTitle(
                'Calendário', 'Selecione abaixo, o último número do seu NIS'),
            const H(36),
            _keyboardNumber(context)
          ],
        ),
      ),
    );
  }
}
