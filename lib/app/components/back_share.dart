import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../utils/app_colors.dart';
import 'w.dart';

class AppShare extends StatefulWidget {
  final double margin;
  const AppShare({Key? key, this.margin = 16}) : super(key: key);

  @override
  State<AppShare> createState() => _AppShareState();
}

class _AppShareState extends State<AppShare> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
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
        margin: EdgeInsets.only(right: widget.margin),
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
    );
  }
}
