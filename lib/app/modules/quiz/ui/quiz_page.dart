import 'package:aid_brazil/app/ad/ad_banner_storage.dart';
import 'package:aid_brazil/app/ad/ad_controller.dart';
import 'package:aid_brazil/app/components/app_banner_ad.dart';
import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/components/w.dart';
import 'package:aid_brazil/app/modules/quiz/quiz_model.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/app_theme.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class QuizPage extends JourneyStatefulWidget {
  final Quiz quiz;

  const QuizPage(this.quiz, {Key? key}) : super(key: key, name: 'QuizPage');

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  BannerAd? banner;

  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.quizStream,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.quizStream,
        body: body(context),
      ),
    );
  }

  Widget body(_) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: const Color(0xFFe6eaec),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.greenDark,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: AppColors.greenDark,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      const W(4),
                      const Icon(
                        Icons.verified_outlined,
                        color: AppColors.greenLight,
                      ),
                      const W(12),
                      Text(
                        '${widget.quiz.percentage.toInt()}%',
                        style: AppTheme.subtitle.copyWith(
                          fontSize: 16,
                          color: AppColors.white,
                        ),
                      ),
                      const W(4),
                    ],
                  ),
                ),
              ],
            ),
            const H(16),
            Text(
              widget.quiz.title,
              style: AppTheme.title,
            ),
            _divisor(),
            ...widget.quiz.options.map((e) => _itemOption(e)).toList(),
            const H(16),
            AppBannerAd(AdBannerStorage.quizStream),
            const H(24),
          ],
        ),
        _bottomButton()
      ],
    );
  }

  Widget _itemOption(QuizOption e) {
    bool isSelected = e == widget.quiz.option;
    return InkWell(
      onTap: () {
        setState(() {
          widget.quiz.option = e;
        });
      },
      child: IgnorePointer(
        ignoring: true,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF005c53) : AppColors.grey,
              borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.only(bottom: 8),
          width: double.maxFinite,
          child: Row(
            children: [
              Radio<QuizOption>(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                value: e,
                groupValue: widget.quiz.option,
                overlayColor: MaterialStateProperty.all(AppColors.greenDark),
                focusColor: AppColors.greenDark,
                hoverColor: AppColors.greenDark,
                activeColor: AppColors.greenLight,
                onChanged: (value) {},
              ),
              const W(8),
              Text(
                e.label,
                style: AppTheme.subtitle.copyWith(
                    color: isSelected ? AppColors.white : AppColors.greenDark),
              )
            ],
          ),
        ),
      ),
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
        child: Row(
          children: [
            if (widget.quiz.title != 'Qual seu Genero')
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(6),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.greenLight,
                    size: 24,
                  ),
                ),
              ),
            Expanded(
              child: InkWell(
                onTap: () {
                  widget.quiz.option!.onTap.call();
                },
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.greenLight,
                  ),
                  width: double.maxFinite,
                  child: const Center(
                    child: Text(
                      'PRÓXIMO PASSO',
                      style: TextStyle(
                          color: AppColors.greenDark,
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
}
