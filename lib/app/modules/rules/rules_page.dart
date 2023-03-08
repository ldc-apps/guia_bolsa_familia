import 'package:aid_brazil/app/ad/ad_banner_storage.dart';
import 'package:aid_brazil/app/ad/ad_controller.dart';
import 'package:aid_brazil/app/components/app_banner_ad.dart';
import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/back.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/components/in_footer_cta.dart';
import 'package:aid_brazil/app/components/loading.dart';
import 'package:aid_brazil/app/components/privacy_policy.dart';
import 'package:aid_brazil/app/modules/calendar/ui/calendar_select_nis_page.dart';
import 'package:aid_brazil/app/modules/rules/rules_model.dart';
import 'package:aid_brazil/app/modules/search_nis/search_nis_model.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/app_theme.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RulesPage extends JourneyStatefulWidget {
  const RulesPage({super.key}) : super(name: 'RulesPage');

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  BannerAd? banner;

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.rulesStream,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.rulesStream,
        body: _body(context),
      ),
    );
  }

  Widget _body(_) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Back(
                onTap: () => AdController.showInterstitialAd(context),
                color: AppColors.greenDark,
                margin: 0,
              ),
              const H(32),
              Container(
                width: double.maxFinite,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                        image: NetworkImage(
                            'https://ldcapps.com/wp-content/uploads/2023/03/veja-se-voce-tem-direito.png'),
                        fit: BoxFit.cover)),
              ),
              const H(16),
              const Text(
                'Conheça as novas regras do Bolsa Família.',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, fontFamily: 'Inter'),
              ),
              const H(32),
              AppBannerAd(AdBannerStorage.rulesStream),
              const H(32),
              const Text(
                'Programa vai pagar R\$ 600 por família, mais R\$ 150 por criança de até 6 anos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, fontFamily: 'Inter'),
              ),
              const H(24),
              const Text(
                'Famílias elegíveis irão migrar automaticamente do Auxílio Brasil para o Bolsa Família, sem necessidade de realizar novo cadastro.\n\nO novo Bolsa Família começa a ser pago pela Caixa Econômica Federal a partir do dia 20 de março. O programa, que substitui o Auxílio Brasil, foi lançado na quinta-feira (2) pelo presidente Luiz Inácio Lula da Silva (PT), e atende famílias em situação de pobreza ou extrema pobreza.\n\nO benefício será de, no mínimo, R\$ 600 por família. O programa ainda conta com novos acréscimos: são mais R\$ 150 por criança de até seis anos e, a partir de junho, um adicional de R\$ 50 por integrante entre 7 e 18 anos incompletos e mulheres gestantes cadastradas na família.',
                style: TextStyle(
                    fontSize: 18, fontFamily: 'Inter', color: Color(0xFF474747), height: 1.5),
              ),
              const H(16),
              const Text(
                'Confira mais informações sobre o novo Bolsa Família:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, fontFamily: 'Inter'),
              ),
              const H(24),
              Theme(
                  data: ThemeData(dividerColor: Colors.transparent),
                  child: Column(
                    children: [
                      for (var e in DoubtRulesItem.itens(_)) _itemDoubt(context, e),
                    ],
                  )),
              const H(16),
              const PrivacyPolicy()
            ],
          ),
        ),
        const H(16),
        InFooterCta(
          onTap: () {
            Navigator.pop(context);
            push(context, const CalendarSelectNisPage());
          },
          icon: Icons.calendar_month,
          label: 'Calendário Bolsa Família',
        )
      ],
    );
  }

  Widget itemStep(BuildContext context, SearchNisStep step) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration:
              BoxDecoration(color: AppColors.greenDark, borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(step.position.toString(),
                style: AppTheme.title.copyWith(color: AppColors.white)),
          ),
        ),
        const H(16),
        Text(
          step.title,
          style: AppTheme.subtitle,
        ),
        if (step.url != null) const H(16),
        if (step.url != null)
          ClipRRect(
            child: CachedNetworkImage(
              imageUrl: step.url!,
              placeholder: (context, url) => const Loading(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: 280,
            ),
          )
      ],
    );
  }

  Widget _itemDoubt(BuildContext context, DoubtRulesItem item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          childrenPadding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
          collapsedIconColor: AppColors.greenDark,
          iconColor: AppColors.greenDark,
          title: Text(
            item.title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF042940)),
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          expandedAlignment: Alignment.centerLeft,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(item.subtitle,
                  style: const TextStyle(color: Color(0xFF042940), fontSize: 18, height: 1.5)),
            )
          ],
        ),
      ),
    );
  }
}
