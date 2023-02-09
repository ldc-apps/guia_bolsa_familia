import 'package:aid_brazil/app/components/exit_page.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ad/ad_banner_storage.dart';
import '../../../ad/ad_controller.dart';
import '../../../components/app_banner_ad.dart';
import '../../../components/app_scaffold.dart';
import '../../../components/divisor.dart';
import '../../../components/h.dart';
import '../../../components/module_title.dart';
import '../../../components/page_title.dart';
import '../../../components/privacy_policy.dart';
import '../../../components/w.dart';
import '../../../dialogs/rate_dialog.dart';
import '../../../utils/app_colors.dart';
import '../../query/ui/query_search_page.dart';
import '../home_model.dart';

class HomePage extends JourneyStatefulWidget {
  const HomePage({Key? key}) : super(key: key, name: 'HomePage');

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.homeStream,
    );
    super.initState();
  }

  String get _getTitleByHour {
    final now = DateTime.now();

    if (now.hour > 0 && now.hour < 12) {
      return 'Bom dia';
    } else if (now.hour > 12 && now.hour < 18) {
      return 'Boa tarde';
    } else if (now.hour > 18 && now.hour < 24) {
      return 'Boa noite';
    }

    return 'Olá';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shared = await SharedPreferences.getInstance();
        bool? rate = shared.getBool('rate');
        if (rate == null) {
          shared.setBool('rate', false);
        }
        if (!rate!) {
          await showDialog(
              context: context, builder: (_) => const RateDialog());
        }
        push(context, ExitPage());
        return true;
      },
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.homeStream,
        body: _body(context),
      ),
    );
  }

  Widget _body(_) {
    final homeItens = HomeItem.itens(_);
    return ListView(
      children: [
        _topCard(),
        const H(24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: AppBannerAd(AdBannerStorage.homeStream),
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: ModuleTitle(
            'Conheça nossos',
            'Serviços',
            boldBottom: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 30,
            crossAxisSpacing: 30,
            children: homeItens
                .map((e) => StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: _homeItem(_, e),
                    ))
                .toList(),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: ModuleTitle('Canais de', 'Atendimento', boldBottom: true),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Divisor(),
              for (var e in HomeItem.bottomItens(_))
                _bottomHomeItem(context, e),
              const Divisor(),
            ],
          ),
        ),
        const H(36),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: PrivacyPolicy(),
        ),
        const H(12),
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
    return InkWell(
      onTap: item.function,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Icon(
                item.icon,
                size: 84,
                color: AppColors.green,
              ),
            ),
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
    );
  }

  Container _topCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: AppColors.greenDark,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicWidth(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF0A4A08),
              ),
              child: Row(
                children: const [
                  Icon(
                    Icons.headset_mic_outlined,
                    size: 18,
                    color: AppColors.greenLight,
                  ),
                  W(8),
                  Text(
                    'Atendimento',
                    style: TextStyle(color: AppColors.white, fontSize: 18),
                  )
                ],
              ),
            ),
          ),
          const H(24),
          PageTitle(_getTitleByHour,
              'Consulte agora a disponibilidade\ndo seu benefício.'),
          const H(32),
          SizedBox(
            width: double.maxFinite,
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.greenLight),
                  elevation: MaterialStateProperty.all(4),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 10))),
              onPressed: () => push(context, const QuerySearchPage()),
              child: const Text(
                'CONSULTAR BOLSA FAMILIA',
                style: TextStyle(
                    color: AppColors.greenDark,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const H(2)
        ],
      ),
    );
  }
}
