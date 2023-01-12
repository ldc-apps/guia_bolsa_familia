import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

import '../../../ad/ad_banner_storage.dart';
import '../../../ad/ad_controller.dart';
import '../../../components/app_banner_ad.dart';
import '../../../components/app_scaffold.dart';
import '../../../components/back.dart';
import '../../../components/back_share.dart';
import '../../../components/background_gradient.dart';
import '../../../components/h.dart';
import '../../../components/module_title.dart';
import '../../../components/privacy_policy.dart';
import '../../../components/w.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/extensions.dart';
import '../../home/home_model.dart';

class CalendarPaymentDay extends StatefulWidget {
  final int nis;
  final List<DateTime> days;
  final DateTime day;
  final int currentSemester;

  const CalendarPaymentDay(this.nis, this.days, this.day, this.currentSemester,
      {Key? key})
      : super(key: key);

  @override
  State<CalendarPaymentDay> createState() => _CalendarPaymentDayState();
}

class _CalendarPaymentDayState extends State<CalendarPaymentDay> {
  BannerAd? banner;
  final ScrollController _scrollController = ScrollController();
  late PageController _pageController;
  late int currentSemester;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.currentSemester);
    currentSemester = widget.currentSemester;
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.calendarPaymentDayStream,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      active: AdController.adConfig.banner.active,
      behavior: AdBannerStorage.calendarPaymentDayStream,
      body: bodyStacked(context),
    );
  }

  ListView bodyStacked(context) {
    return ListView(
      controller: _scrollController,
      padding: EdgeInsets.zero,
      children: [
        ContainerBackground(
          height: 230,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _backButton(context),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Próximo pagamento',
                      style:
                          AppTheme.subtitle.copyWith(color: Colors.grey[400]),
                    ),
                    const H(8),
                    Text(
                      "${DateFormat(DateFormat.DAY, 'pt_BR').format(widget.day)} de ${DateFormat(DateFormat.MONTH, 'pt_BR').format(widget.day).capitalize()}",
                      style: const TextStyle(
                          letterSpacing: 1.2,
                          color: AppColors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.w900),
                    ),
                    const H(8),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Faltam ',
                            style: AppTheme.subtitle
                                .copyWith(color: Colors.grey[400])),
                        TextSpan(
                            text: getDaysOut(),
                            style: AppTheme.subtitle
                                .copyWith(color: Colors.yellow)),
                        TextSpan(
                            text: ' dias para receber!',
                            style: AppTheme.subtitle
                                .copyWith(color: Colors.grey[400])),
                      ]),
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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBannerAd(AdBannerStorage.calendarPaymentDayStream),
              const H(24),
              const ModuleTitle('Calendário', '2023', boldBottom: true),
              const H(16),
              Row(
                children: [
                  IgnorePointer(
                    ignoring: currentSemester == 1,
                    child: InkWell(
                      onTap: () {
                        if (currentSemester == 2) {
                          _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                        }
                      },
                      child: Icon(
                        Icons.arrow_circle_left_outlined,
                        size: 32,
                        color: currentSemester == 2
                            ? AppColors.greenDark
                            : AppColors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                        child: Text(
                      '$currentSemesterº Semestre',
                      style: AppTheme.subtitle.copyWith(fontSize: 24),
                    )),
                  ),
                  IgnorePointer(
                    ignoring: currentSemester == 2,
                    child: InkWell(
                      onTap: () {
                        if (currentSemester == 1) {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                        }
                      },
                      child: Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 32,
                        color: currentSemester == 1
                            ? AppColors.greenDark
                            : AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const H(48),
              SizedBox(
                width: double.maxFinite,
                height: 242,
                child: PageView(
                  onPageChanged: (i) {
                    setState(() {
                      currentSemester = i + 1;
                    });
                  },
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  children: [
                    _tablePayment(context, widget.days.getRange(0, 6).toList()),
                    _tablePayment(
                        context, widget.days.getRange(6, 12).toList()),
                  ],
                ),
              ),
              const H(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentSemester == 1
                          ? AppColors.greenDark
                          : const Color(0xFFd9d9d9),
                      boxShadow: currentSemester == 1 ? AppTheme.shadow : null,
                    ),
                  ),
                  const W(8),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentSemester == 2
                          ? AppColors.greenDark
                          : const Color(0xFFd9d9d9),
                      boxShadow: currentSemester == 2 ? AppTheme.shadow : null,
                    ),
                  ),
                ],
              ),
              const H(64),
              Row(
                children: [
                  _homeItem(_, HomeItem.itens(_)[4]),
                  const W(16),
                  _homeItem(_, HomeItem.itens(_)[2])
                ],
              ),
              const H(32),
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

  Row _labelBody(IconData icon, String label, String sublabel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppColors.greenDark,
          size: 42,
        ),
        const W(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Color(0xFF797979))),
              const H(4),
              Text(sublabel, style: AppTheme.title),
            ],
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

  Widget _backButton(context) {
    return Back(
        onTap: () async => await AdController.showInterstitialAd(context),
        label: 'Voltar',
        action: const AppShare());
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

  String getDaysOut() {
    final now = DateTime.now();
    final out = widget.day
        .difference(DateTime(now.year, now.month, now.day))
        .inDays
        .toString();
    return out == '0' ? 'Hoje' : out;
  }

  Widget _tablePayment(_, List<DateTime> days) {
    return StaggeredGrid.count(
      crossAxisCount: 3,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      axisDirection: AxisDirection.down,
      children: days
          .map((e) => StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: _cellItem(_, e),
              ))
          .toList(),
    );
  }

  Widget _cellItem(_, DateTime date) {
    final bool current = date == widget.day;
    final bool inPast = date.month < widget.day.month;
    return Container(
      decoration: BoxDecoration(
        color: inPast
            ? const Color(0xFFf7f7f7)
            : (current ? AppColors.greenDark : AppColors.white),
        border: Border.all(
            color: !inPast || current
                ? AppColors.greenDark
                : const Color(0xFFf7f7f7),
            width: 1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('MMM', 'pt_BR').format(date).toUpperCase(),
            style: TextStyle(
              color: inPast
                  ? const Color(0xFFb9b9b9)
                  : (current ? AppColors.white : AppColors.greenDark),
              fontWeight: FontWeight.w400,
              fontSize: 24,
            ),
          ),
          const H(4),
          Text(
            DateFormat(DateFormat.DAY, 'pt_BR').format(date),
            style: TextStyle(
              color: inPast
                  ? const Color(0xFFb9b9b9)
                  : (current ? AppColors.white : AppColors.greenDark),
              fontWeight: FontWeight.w700,
              fontSize: 44,
            ),
          ),
        ],
      ),
    );
  }
}
