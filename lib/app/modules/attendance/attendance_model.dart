import 'package:aid_brazil/app/ad/ad_controller.dart';
import 'package:aid_brazil/app/modules/attendance/ui/attendance_phone_caixa_page.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AttendanceHome {
  final String title;
  final String subtitle;
  final IconData icon;
  final Function() onTap;

  AttendanceHome(this.title, this.subtitle, this.icon, this.onTap);

  static List<AttendanceHome> itens(_) => [
        AttendanceHome(
          'Telefones da CAIXA',
          'Consulte os telefones para atendimento',
          Icons.call_outlined,
          () => push(_, const AttendancePhoneCaixaPage()),
        ),
        AttendanceHome(
          'Aplicativos da CAIXA',
          'Conheça todos os aplicativos da CAIXA',
          Icons.open_in_new,
          () async {
            await AdController.showInterstitialAd(
              _,
              onComplete: () => execUrl(
                  'https://play.google.com/store/apps/developer?id=Caixa+Econ%C3%B4mica+Federal'),
              pop: false,
            );
          },
        ),
        AttendanceHome(
          'Whatsapp CAIXA',
          'Tire suas dúvidas pelo núemro 0800 104 0 104',
          Icons.whatsapp,
          () => launchUrlString("https://wa.me/08001040104"),
        ),
      ];
}
