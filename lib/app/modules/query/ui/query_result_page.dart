import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../../ad/ad_banner_storage.dart';
import '../../../ad/ad_controller.dart';
import '../../../components/app_banner_ad.dart';
import '../../../components/app_scaffold.dart';
import '../../../components/back.dart';
import '../../../components/background_gradient.dart';
import '../../../components/h.dart';
import '../../../components/privacy_policy.dart';
import '../../../components/w.dart';
import '../../../dialogs/rate_dialog.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_theme.dart';
import '../../home/home_model.dart';
import '../query_model.dart';

class QueryResultPage extends JourneyStatefulWidget {
  final QueryResult query;

  const QueryResultPage(this.query, {Key? key}) : super(key: key, name: 'QueryResultPage');

  @override
  State<QueryResultPage> createState() => _QueryResultPageState();
}

class _QueryResultPageState extends State<QueryResultPage> {
  BannerAd? banner;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      onWillPop: () async {
        await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => const RateDialog());
        await AdController.showInterstitialAd(context);
        return true;
      },
      active: AdController.adConfig.banner.active,
      behavior: AdBannerStorage.queryResultStream,
      body: _bodyStacked(context),
    );
  }

  @override
  void initState() {
    AdController.fetchInterstitialAd(AdController.adConfig.intersticial.id);
    AdController.fetchBanner(
      AdController.adConfig.banner.id,
      AdBannerStorage.queryResultStream,
    );
    super.initState();
  }

  Widget _backButton(context) {
    return Back(
      onTap: () async {
        await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => const RateDialog());
        await AdController.showInterstitialAd(context);
      },
      label: 'Voltar',
      action: InkWell(
        onTap: () {
          Share.share('''
          Olha só o que eu acabei de descobrir 😱.
          Um app que te ensina tudo sobre o Bolsa Família,
          e ainda te ajuda à saber se você tem direito ao benefício.


          Pra aproveitar esse conteúdo, basta instalar o app clicando no link abaixo.
          👇


          ✅ https://play.google.com/store/apps/details?id=com.ldcapps.bf_brasil
          ''');
        },
        child: Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFF0A4A08),
          ),
          child: Row(
            children: const [
              Icon(
                Icons.share_outlined,
                size: 18,
                color: AppColors.greenLight,
              ),
              W(8),
              Text(
                'Compartilhar',
                style: TextStyle(color: AppColors.white, fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(_) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          transform: Matrix4.translationValues(0.0, -50.0, 0.0),
          child: Column(
            children: [
              AppBannerAd(AdBannerStorage.queryResultStream),
              const H(24),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _labelBody(
                        Icons.account_circle_outlined,
                        'Nome Completo',
                        widget.query.name,
                      ),
                      _divisor(),
                      _labelBody(
                        Icons.event,
                        'Próximo Pagamento',
                        "${DateFormat(DateFormat.DAY, 'pt_BR').format(widget.query.paymentDate)} de ${DateFormat(DateFormat.MONTH, 'pt_BR').format(widget.query.paymentDate)}"
                            .toUpperCase(),
                      ),
                      _divisor(),
                      _labelBody(
                        Icons.pin_drop_outlined,
                        'Cidade - UF',
                        widget.query.locale,
                      ),
                      _divisor(),
                      _labelBody(
                        Icons.mark_email_unread_outlined,
                        'Mensagens',
                        widget.query.message,
                      ),
                    ],
                  ),
                ),
              ),
              const H(36),
              Row(
                children: [
                  _homeItem(_, HomeItem.itens(_)[4]),
                  const W(16),
                  _homeItem(_, HomeItem.itens(_)[6])
                ],
              ),
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

  ListView _bodyStacked(context) {
    return ListView(
      controller: _scrollController,
      padding: EdgeInsets.zero,
      children: [
        ContainerBackground(
          height: 270,
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
                      'Valor do benefício',
                      style:
                          AppTheme.subtitle.copyWith(color: Colors.grey[400]),
                    ),
                    const H(8),
                    const Text(
                      'R\$ 600,00',
                      style: TextStyle(
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
                            text: widget.query.paymentDate
                                .difference(DateTime.now())
                                .inDays
                                .toString(),
                            style: AppTheme.subtitle.copyWith(
                                color: Colors.yellow,
                                fontWeight: FontWeight.w900)),
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
        _body(context),
      ],
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
}
