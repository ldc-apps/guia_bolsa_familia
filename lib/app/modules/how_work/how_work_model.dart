import 'package:flutter/material.dart';

import 'ui/how_work_available_for.dart';
import 'ui/how_work_benefit_page.dart';
import 'ui/how_work_how_get.dart';
import 'ui/how_work_how_work_page.dart';
import 'ui/how_work_what_values_paid.dart';

class HowWorkHome {
  final String title;
  final String subtitle;
  final Widget widget;

  HowWorkHome(this.title, this.subtitle, this.widget);

  static List<HowWorkHome> itens(_) => [
        HowWorkHome(
          'O\'Que é o Bolsa Família',
          'Veja o\'que é e como funciona.',
          const HowWorkHowWorkPage(),
        ),
        HowWorkHome(
          'Quais valores são pagos',
          'Veja os valores que você pode receber.',
          const HowWorkWhatValuesPaidPage(),
        ),
        HowWorkHome(
          'Quem pode participar do Bolsa Família',
          'Veja quem pode participar do Bolsa Família',
          const HowWorkAvailableFor(),
        ),
        HowWorkHome(
          'Como conseguir o Bolsa Família',
          'Como funciona para conseguir o Bolsa Família',
          const HowWorkHowGet(),
        ),
        HowWorkHome(
          'Como receber os benefícios',
          'Saiba como receber seu Bolsa Família',
          const HowWorkBenefit(),
        ),
      ];
}
