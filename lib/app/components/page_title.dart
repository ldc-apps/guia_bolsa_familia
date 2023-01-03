import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const PageTitle(
    this.title,
    this.subtitle, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            )),
        const H(6),
        Text(
          subtitle,
          style: const TextStyle(color: Color(0xFFcdd4d9), fontSize: 19),
        ),
      ],
    );
  }
}
