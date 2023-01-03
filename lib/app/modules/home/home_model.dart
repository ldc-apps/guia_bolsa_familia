import 'package:aid_brazil/app/ad/ad_controller.dart';
import 'package:aid_brazil/app/modules/attendance/ui/attendance_home_page.dart';
import 'package:aid_brazil/app/modules/calendar/ui/calendar_select_nis_page.dart';
import 'package:aid_brazil/app/modules/doubt/ui/doubts_page.dart';
import 'package:aid_brazil/app/modules/how_work/ui/how_work_home_page.dart';
import 'package:aid_brazil/app/modules/loan/ui/loan_home_page.dart';
import 'package:aid_brazil/app/modules/new/ui/news_page.dart';
import 'package:aid_brazil/app/modules/quiz/ui/quiz_home_page.dart';
import 'package:aid_brazil/app/modules/search_nis/ui/search_nis_home_page.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';

import '../how_register/ui/how_register_home_page.dart';

class HomeItem {
  final String label;
  final IconData icon;
  final Function() function;
  IconData? action;

  HomeItem(this.label, this.icon, this.function, {this.action});

  static List<HomeItem> bottomItens(_) => [
        HomeItem(
          'Central de\nAtendimento',
          Icons.headset_mic_outlined,
          () => push(_, const AttendanceHomePage()),
          action: Icons.arrow_forward_ios_outlined,
        ),
        HomeItem(
          'Encontre uma\nAgência CAIXA',
          Icons.account_balance_outlined,
          () async {
            await AdController.showInterstitialAd(
              _,
              onComplete: () => execUrl(
                  'https://www.caixa.gov.br/atendimento/paginas/encontre-a-caixa.aspx'),
              pop: false,
            );
          },
          action: Icons.open_in_new_outlined,
        ),
      ];

  static List<HomeItem> itens(_) => [
        HomeItem(
          'Encontre seu NIS\ncom seu CPF',
          Icons.person_search_outlined,
          () => push(_, const SearchNisHomePage()),
        ),
        HomeItem(
          'Calendário de\nPagamentos',
          Icons.date_range_outlined,
          () => push(_, const CalendarSelectNisPage()),
        ),
        HomeItem(
          'Veja se você\ntem direito',
          Icons.rule,
          () => push(_, const QuizHomePage()),
        ),
        HomeItem(
          'Como se\ncadastrar',
          Icons.contact_page_outlined,
          () => push(_, const HowRegisterHomePage()),
        ),
        HomeItem(
          'Empréstimo\ndo Bolsa Família',
          Icons.currency_exchange_outlined,
          () => push(_, const LoanHomePage()),
        ),
        HomeItem(
          'Como funciona\ne valores',
          Icons.payments_outlined,
          () => push(_, const HowWorkHomePage()),
        ),
        HomeItem(
          'Notícias',
          Icons.rss_feed,
          () => push(_, const NewsPage()),
        ),
        HomeItem(
          'Perguntas\nfrequentes',
          Icons.quiz_outlined,
          () => push(_, const DoubtsPage()),
        ),
      ];
}
