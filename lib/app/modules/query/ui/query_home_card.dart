import 'package:aid_brazil/app/components/button.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/modules/query/ui/query_search_page.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:aid_brazil/app/utils/theme_utils.dart';
import 'package:flutter/material.dart';

class QueryHomeCard extends StatelessWidget {
  const QueryHomeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: IntrinsicHeight(
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          margin: const EdgeInsets.only(top: 32, right: 24, left: 24),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: ThemeUtils.shadow),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Consulta rápida do Bolsa Família\nBrasil e Bolsa Família.',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.greenDark,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const H(8),
              const Text(
                'Para realizar sua consulta basta ter em\nmãos seu NIS.',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.green,
                ),
              ),
              const H(26),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      label: 'Consulta rápida',
                      onPressed: () => push(const QuerySearchPage()),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
