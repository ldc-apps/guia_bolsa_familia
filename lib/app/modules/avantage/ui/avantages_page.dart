import 'package:aid_brazil/app/ad/ad_banner_storage.dart';
import 'package:aid_brazil/app/components/app_banner_ad.dart';
import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/back.dart';
import 'package:aid_brazil/app/components/background_gradient.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/components/w.dart';
import 'package:aid_brazil/app/modules/avantage/avantage_model.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../ad/ad_controller.dart';

class AvantagesPage extends JourneyStatefulWidget {
  const AvantagesPage({Key? key}) : super(key: key, name: 'AvantagesPage');

  @override
  State<AvantagesPage> createState() => _AvantagesPageState();
}

class _AvantagesPageState extends State<AvantagesPage> {
  int _currentIndex = 0;
  int _currentIndex2 = 0;
  final List<Avantage> _itens = Avantage.itens;
  final List<Avantage> _itens2 = Avantage.itens;

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
                  'Saiba quais são os\ntipos de benefício.',
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
      behavior: AdBannerStorage.avantagesStream,
      body: bodyStacked(context),
    );
  }

  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.avantagesStream,
    );
    super.initState();
  }

  Widget _body(_) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              H(16),
              Text(
                'Tipos de Benefícios',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.greenDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              H(8),
              Text(
                'Conforme informações divulgadas pelo Ministério da Cidadania, o programa Bolsa Família será formado pelos seguintes benefícios',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.greenDark,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
              H(8),
              Text(
                'Após aprovação do novo benefício, o Bolsa Família deve ser revogado e o governo passará a pagar nove modalidades diferentes de benefícios. O Bolsa Família será composto por três modalidades que formarão o núcleo básico do programa e outras que funcionarão como ferramentas de inserção socioeconômica.',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.greenDark,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
              ),
              H(16),
              Text(
                'Confira quais benefícios serão pagos no Bolsa Família:',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.greenDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        const H(16),
        Center(child: AppBannerAd(AdBannerStorage.avantagesStream)),
        Stepper(
          physics: const NeverScrollableScrollPhysics(),
          type: StepperType.vertical,
          controlsBuilder: (_, details) => Row(
            children: [
              if (details.currentStep > 0)
                InkWell(
                  onTap: () => details.onStepCancel!.call(),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.greenLight)),
                    margin: const EdgeInsets.only(top: 12),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                    child: const Text(
                      'Voltar',
                      style: TextStyle(
                          color: AppColors.greenLight,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              if (details.currentStep > 0) const W(8),
              if (details.currentStep < _itens.length - 1)
                InkWell(
                  onTap: () => details.onStepContinue!.call(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.greenLight,
                      border: Border.all(color: AppColors.greenLight),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.only(top: 12),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                    child: const Text(
                      'Próximo',
                      style: TextStyle(
                          color: AppColors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              const Spacer(),
            ],
          ),
          currentStep: _currentIndex,
          onStepTapped: (i) => setState(() => _currentIndex = i),
          onStepContinue: () => setState(() => _currentIndex++),
          onStepCancel: () => setState(() => _currentIndex--),
          steps: _itens.map((e) => _itemStepper(_, e)).toList(),
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Benefícios sumplementares:',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: AppColors.greenDark,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Stepper(
          physics: const NeverScrollableScrollPhysics(),
          type: StepperType.vertical,
          controlsBuilder: (_, details) => Row(
            children: [
              if (details.currentStep > 0)
                InkWell(
                  onTap: () => details.onStepCancel!.call(),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.greenLight)),
                    margin: const EdgeInsets.only(top: 12),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                    child: const Text(
                      'Voltar',
                      style: TextStyle(
                          color: AppColors.greenLight,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              if (details.currentStep > 0) const W(8),
              if (details.currentStep < _itens2.length - 1)
                InkWell(
                  onTap: () => details.onStepContinue!.call(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.greenLight,
                      border: Border.all(color: AppColors.greenLight),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.only(top: 12),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                    child: const Text(
                      'Próximo',
                      style: TextStyle(
                          color: AppColors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              const Spacer(),
            ],
          ),
          currentStep: _currentIndex2,
          onStepTapped: (i) => setState(() => _currentIndex2 = i),
          onStepContinue: () => setState(() => _currentIndex2++),
          onStepCancel: () => setState(() => _currentIndex2--),
          steps: _itens2.map((e) => _itemStepper2(_, e)).toList(),
        ),
      ],
    );
  }

  Step _itemStepper(_, Avantage item) {
    return Step(
      isActive: _currentIndex >= _itens.indexOf(item),
      title: Text(
        item.title,
        style: const TextStyle(
            color: AppColors.greenDark,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
      // subtitle: Text(
      //   item.subtitle,
      //   style: const TextStyle(
      //       color: AppColors.greenDark,
      //       fontSize: 18,
      //       fontWeight: FontWeight.w400),
      // ),
      content: Column(
        children: [
          Text(
            item.description,
            style: const TextStyle(
                color: AppColors.greenDark,
                fontSize: 18,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Step _itemStepper2(_, Avantage item) {
    return Step(
      isActive: _currentIndex2 >= _itens2.indexOf(item),
      title: Text(
        item.title,
        style: const TextStyle(
            color: AppColors.greenDark,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
      // subtitle: Text(
      //   item.subtitle,
      //   style: const TextStyle(
      //       color: AppColors.greenDark,
      //       fontSize: 18,
      //       fontWeight: FontWeight.w400),
      // ),
      content: Column(
        children: [
          Text(
            item.description,
            style: const TextStyle(
                color: AppColors.greenDark,
                fontSize: 18,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
