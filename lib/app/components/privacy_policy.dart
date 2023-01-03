import 'package:aid_brazil/app/components/w.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => execUrl('https://ldcapps.com/guia-auxilio-emergencial'),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'LDC APPS',
            textAlign: TextAlign.center,
            style:
                TextStyle(color: AppColors.green, fontWeight: FontWeight.bold),
          ),
          Row(
            children: const [
              Icon(
                Icons.info_outline,
                color: AppColors.green,
                size: 16,
              ),
              W(4),
              Text(
                'Política de privacidade',
                style: TextStyle(color: AppColors.green, fontSize: 18),
              )
            ],
          )
        ],
      ),
    );
  }
}
