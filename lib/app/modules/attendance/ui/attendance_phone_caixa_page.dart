import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../ad/ad_banner_storage.dart';
import '../../../ad/ad_controller.dart';
import '../../../components/app_banner_ad.dart';
import '../../../components/app_card.dart';
import '../../../components/app_scaffold.dart';
import '../../../components/back.dart';
import '../../../components/background_gradient.dart';
import '../../../components/divisor.dart';
import '../../../components/h.dart';
import '../../../components/module_title.dart';
import '../../../components/page_title.dart';
import '../../../components/privacy_policy.dart';
import '../../../components/w.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_theme.dart';
import '../../home/home_model.dart';

class AttendancePhoneCaixaPage extends JourneyStatefulWidget {
  const AttendancePhoneCaixaPage({super.key}) : super(name: 'AttendancePhoneCaixaPage');

  @override
  State<AttendancePhoneCaixaPage> createState() =>
      _AttendancePhoneCaixaPageState();
}

class _AttendancePhoneCaixaPageState extends State<AttendancePhoneCaixaPage> {
  BannerAd? banner;

  Widget bodyStacked(BuildContext _) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ContainerBackground(
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Back(
                onTap: () => AdController.showInterstitialAd(context),
              ),
              const H(8),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: PageTitle('Telefones da\nCAIXA',
                      'A CAIXA tem diversos canais digitais para atender você, confira abaixo.'))
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
    return WillPopScope(
      onWillPop: () async => await AdController.showInterstitialAd(context),
      child: AppScaffold(
        active: AdController.adConfig.banner.active,
        behavior: AdBannerStorage.attendancePhoneCaixaStream,
        body: bodyStacked(context),
      ),
    );
  }

  @override
  void initState() {
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.attendancePhoneCaixaStream,
    );
    super.initState();
  }

  Container _aidBrazilBox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColors.grey, borderRadius: BorderRadius.circular(16)),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bolsa Família', style: AppTheme.title),
          const H(6),
          Row(
            children: [
              const Icon(
                Icons.headset_mic_outlined,
                color: AppColors.green,
              ),
              const W(8),
              Text(
                '111',
                style: AppTheme.subtitle.copyWith(color: AppColors.green),
              ),
            ],
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1.6,
            height: 40,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(
                  Icons.smart_toy_outlined,
                  color: AppColors.green,
                ),
              ),
              const W(8),
              Expanded(
                child: Text(
                  'O  atendimento  eletrônico  está  disponível  24  horas  por  dia,  7  dias  por  semana.',
                  style: AppTheme.subtitle.copyWith(height: 1.4),
                ),
              )
            ],
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1.6,
            height: 40,
          ),
          _callButton('111')
        ],
      ),
    );
  }

  Widget _body(BuildContext _) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            transform: Matrix4.translationValues(0, -80, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBannerAd(AdBannerStorage.attendancePhoneCaixaStream),
                const H(32),
                const ModuleTitle('Atendimento', 'Digital', boldBottom: true),
                const H(24),
                _aidBrazilBox(),
                const H(16),
                _caixaCidBox(),
                const H(16),
                AppCard(
                  title: 'Outros telefones CAIXA',
                  subtitle: 'Encontre mais formas de contato no site da CAIXA',
                  icon: Icons.open_in_new,
                  function: () async {
                    await AdController.showInterstitialAd(
                      _,
                      onComplete: () => execUrl(
                          'https://www.caixa.gov.br/atendimento/paginas/default.aspx'),
                      pop: false,
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: ModuleTitle('Atendimento', 'Presencial',
                      boldBottom: true),
                ),
                const H(16),
                _bottomHomeItem(context, HomeItem.bottomItens(_).last)
              ],
            ),
          ),
          const PrivacyPolicy()
        ],
      ),
    );
  }

  Widget _bottomHomeItem(BuildContext context, HomeItem item) {
    return Column(
      children: [
        const Divisor(),
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

  Container _caixaCidBox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColors.grey, borderRadius: BorderRadius.circular(16)),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('CAIXA Cidadão', style: AppTheme.title),
          const H(6),
          Row(
            children: [
              const Icon(
                Icons.headset_mic_outlined,
                color: AppColors.green,
              ),
              const W(8),
              Text(
                '0800 726 0270',
                style: AppTheme.subtitle.copyWith(color: AppColors.green),
              ),
            ],
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1.6,
            height: 40,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(
                  Icons.check_circle_outline,
                  color: AppColors.green,
                ),
              ),
              const W(8),
              Expanded(
                child: Text(
                  'Atendimento   referente   a   PIS,   Benefícios   Sociais,   FGTS   e   Cartão Social',
                  style: AppTheme.subtitle.copyWith(height: 1.4),
                ),
              )
            ],
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1.6,
            height: 40,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(
                  Icons.smart_toy_outlined,
                  color: AppColors.green,
                ),
              ),
              const W(8),
              Expanded(
                child: Text(
                  'O   atendimento   eletrônico   está   disponível   24   horas   por   dia,   7   dias   por   semana.',
                  style: AppTheme.subtitle.copyWith(height: 1.4),
                ),
              )
            ],
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1.6,
            height: 40,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(
                  Icons.support_agent,
                  color: AppColors.green,
                ),
              ),
              const W(8),
              Expanded(
                child: Text(
                  'O   atendimento   humano   ocorre   de   segunda   a   sexta-feira,   das   8h   às   21h,   e   aos   sábados,   das   10h   às   16h.',
                  style: AppTheme.subtitle.copyWith(height: 1.4),
                ),
              )
            ],
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1.6,
            height: 40,
          ),
          _callButton('0800 726 0207')
        ],
      ),
    );
  }

  Widget _callButton(String phone) {
    return InkWell(
      onTap: () => launchUrlString("tel://$phone"),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.green,
        ),
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            W(24),
            Text(
              'LIGAR AGORA',
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900),
            ),
            W(16),
            Icon(
              Icons.call,
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
