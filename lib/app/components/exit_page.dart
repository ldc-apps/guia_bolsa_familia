import 'package:aid_brazil/app/ad/ad_banner_storage.dart';
import 'package:aid_brazil/app/ad/ad_controller.dart';
import 'package:aid_brazil/app/components/app_banner_ad.dart';
import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/divisor.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/components/module_title.dart';
import 'package:aid_brazil/app/components/page_title.dart';
import 'package:aid_brazil/app/components/privacy_policy.dart';
import 'package:aid_brazil/app/components/w.dart';
import 'package:aid_brazil/app/modules/home/home_model.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitPage extends StatefulWidget {
  const ExitPage({Key? key}) : super(key: key);

  @override
  State<ExitPage> createState() => _ExitPageState();
}

class _ExitPageState extends State<ExitPage> {
  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.exitStream,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      active: AdController.adConfig.banner.active,
      behavior: AdBannerStorage.exitStream,
      body: body(context),
    );
  }

  Widget body(_) {
    return ListView(
      children: [
        _topCard(),
        const H(24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: AppBannerAd(AdBannerStorage.exitStream),
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
          Row(
            children: [
              IntrinsicWidth(
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
                        Icons.headset_mic_outlined,
                        size: 18,
                        color: AppColors.greenLight,
                      ),
                      W(8),
                      Text(
                        'Atendimento',
                        style: TextStyle(color: AppColors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: const Color(0xFF0A4A08),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Icon(
                    Icons.close,
                    color: Color(0xFFD7F857),
                  ),
                ),
              )
            ],
          ),
          const H(24),
          const PageTitle(
              'Você deseja\nrealmente sair?', 'Confirme sua intenção de saída'),
          const H(32),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF0A4A08)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 10))),
                  onPressed: () async => Navigator.pop(context),
                  child: const Text(
                    'NÃO',
                    style: TextStyle(
                        color: Color(0xFFD7F857),
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const W(16),
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.greenLight),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 10))),
                  onPressed: () async {
                    Navigator.pop(context);
                    SystemNavigator.pop();
                  },
                  child: const Text(
                    'SIM',
                    style: TextStyle(
                        color: AppColors.greenDark,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          const H(2)
        ],
      ),
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
}
