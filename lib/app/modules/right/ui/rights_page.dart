import 'package:aid_brazil/app/ad/ad_banner_storage.dart';
import 'package:aid_brazil/app/components/app_banner_ad.dart';
import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/back.dart';
import 'package:aid_brazil/app/components/background_gradient.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/modules/right/right_model.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../ad/ad_controller.dart';

class RightsPage extends JourneyStatefulWidget {
  const RightsPage({Key? key}) : super(key: key, name: 'RightsPage');

  @override
  State<RightsPage> createState() => _RightsPageState();
}

class _RightsPageState extends State<RightsPage> {
  int _currentIndex = 0;
  final List<Right> _itens = Right.itens;

  BannerAd? banner;

  ListView bodyStacked(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ContainerBackground(
          height: 126,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Back(
                onTap: () => AdController.showInterstitialAd(context),
                label: 'Início',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 54),
                child: Text(
                  'Saiba se você tem\ndireito ao Bolsa Família.',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        const H(4),
        _body(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      active: AdController.adConfig.banner.active,
      behavior: AdBannerStorage.rightsStream,
      body: bodyStacked(context),
    );
  }

  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.rightsStream,
    );
    super.initState();
  }

  Widget _body(_) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const H(16),
        ...Right.topics.map((e) => _itemTopic(_, e)).toList(),
        AppBannerAd(AdBannerStorage.rightsStream),
        Stepper(
          physics: const NeverScrollableScrollPhysics(),
          type: StepperType.vertical,
          controlsBuilder: (_, details) => const SizedBox(),
          // controlsBuilder: (_, details) => Row(
          //   children: [
          //     if (details.currentStep > 0)
          //       InkWell(
          //         onTap: () => details.onStepCancel!.call(),
          //         child: Container(
          //           decoration: BoxDecoration(
          //               color: AppColors.white,
          //               borderRadius: BorderRadius.circular(16),
          //               border: Border.all(color: AppColors.greenLight)),
          //           margin: const EdgeInsets.only(top: 12),
          //           padding:
          //               const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
          //           child: const Text(
          //             'Voltar',
          //             style: TextStyle(
          //                 color: AppColors.greenLight,
          //                 fontWeight: FontWeight.w500),
          //           ),
          //         ),
          //       ),
          //     if (details.currentStep > 0) const W(8),
          //     if (details.currentStep < _itens.length - 1)
          //       InkWell(
          //         onTap: () => details.onStepContinue!.call(),
          //         child: Container(
          //           decoration: BoxDecoration(
          //             color: AppColors.greenLight,
          //             border: Border.all(color: AppColors.greenLight),
          //             borderRadius: BorderRadius.circular(16),
          //           ),
          //           margin: const EdgeInsets.only(top: 12),
          //           padding:
          //               const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
          //           child: const Text(
          //             'Próximo',
          //             style: TextStyle(
          //                 color: AppColors.white, fontWeight: FontWeight.w500),
          //           ),
          //         ),
          //       ),
          //     const Spacer(),
          //   ],
          // ),
          currentStep: 8,
          onStepTapped: (i) => setState(() => _currentIndex = i),
          onStepContinue: () => setState(() => _currentIndex++),
          onStepCancel: () => setState(() => _currentIndex--),
          steps: _itens.map((e) => _itemStepper(_, e)).toList(),
        ),
      ],
    );
  }

  Step _itemStepper(_, Right item) {
    return Step(
      isActive: true,
      title: Text(
        item.title,
        style: const TextStyle(
            color: AppColors.greenDark,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        item.subtitle,
        style: const TextStyle(
            color: AppColors.green, fontSize: 18, fontWeight: FontWeight.w400),
      ),
      content: Text(
        item.description,
        style: const TextStyle(
            color: AppColors.greenDark,
            fontSize: 18,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _itemTopic(_, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
                color: AppColors.greenDark, shape: BoxShape.circle),
          ),
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.start,
              style: const TextStyle(color: AppColors.greenDark),
            ),
          ),
        ],
      ),
    );
  }
}
