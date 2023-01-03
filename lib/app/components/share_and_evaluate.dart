import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/app_colors.dart';
import 'w.dart';

class ShareAndEvaluate extends StatelessWidget {
  const ShareAndEvaluate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Share.share('''
                Olá! Esse é melhor app gratuito sobre o Auxilio Brasil.
                Aqui você faz sua consulta e vê o quanto tem para receber.
                Vê o calendário e o melhor dia para receber seu Bolsa Família!
                E ainda tiramos todas as suas dúvidas!
                Baixe nosso app agora, e faça sua consulta!
              ''');
            },
            child: Row(
              children: const [
                Icon(
                  Icons.share_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                W(8),
                Text(
                  'Compartilhar',
                  style: TextStyle(color: AppColors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          const W(16),
          InkWell(
            onTap: () => launchUrl(
                Uri.parse(
                    'https://play.google.com/store/apps/details?id=com.ldcapps.bf_brasil'),
                mode: LaunchMode.externalApplication),
            child: Row(
              children: const [
                Icon(
                  Icons.star_outline,
                  color: Colors.white,
                  size: 20,
                ),
                W(8),
                Text(
                  'Availar app',
                  style: TextStyle(color: AppColors.white, fontSize: 18),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
