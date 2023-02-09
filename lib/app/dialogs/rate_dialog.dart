import 'dart:ui';

import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/button.dart';
import '../components/h.dart';
import '../components/w.dart';
import '../utils/app_colors.dart';

class RateDialog extends StatefulWidget {
  const RateDialog({Key? key}) : super(key: key);

  @override
  State<RateDialog> createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding: const EdgeInsets.all(20),
          children: [
            Column(
              children: [
                const H(16),
                Image.asset('assets/images/found_data.png'),
                const H(32),
                const Text('Gostou do app?',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.greenDark)),
                const H(8),
                const Text(
                    'Sua opinião é importante, avalie nosso app\nna loja, é rápido e prático.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.greenDark,
                    )),
                const H(32),
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Expanded(
                        child: Button(
                          label: empty,
                          child: Row(
                            children: const [
                              Icon(
                                Icons.open_in_new,
                                color: Colors.white,
                              ),
                              W(12),
                              Text('Avaliar',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white))
                            ],
                          ),
                          onPressed: () async {
                            final shared =
                                await SharedPreferences.getInstance();
                            bool? rate = shared.getBool('rate');
                            if (rate != null && !rate) {
                              launchUrl(
                                  Uri.parse(
                                      'https://play.google.com/store/apps/details?id=com.ldcapps.bf_brasil'),
                                  mode: LaunchMode.externalApplication);
                              Navigator.pop(context);

                              shared.setBool('rate', true);
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: Button(
                          label: 'Agora não',
                          color: AppColors.white,
                          textColor: AppColors.beige,
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
