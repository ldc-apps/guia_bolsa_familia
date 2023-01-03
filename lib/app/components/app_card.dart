import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'h.dart';
import 'w.dart';

class AppCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Function() function;

  const AppCard(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        width: double.maxFinite,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: AppColors.grey),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const H(8),
            Text(title,
                style: const TextStyle(
                    color: AppColors.greenDark,
                    fontSize: 24,
                    fontWeight: FontWeight.w900)),
            const H(8),
            Row(
              children: [
                Expanded(
                    child: Text(subtitle,
                        style: const TextStyle(
                            color: AppColors.greenDark, fontSize: 18))),
                const W(16),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color(0xFFE45200),
                      borderRadius: BorderRadius.circular(4)),
                  child: Icon(
                    icon,
                    color: AppColors.white,
                    size: 24,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
