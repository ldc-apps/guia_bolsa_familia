import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ModuleTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool boldBottom;

  const ModuleTitle(this.title, this.subtitle,
      {Key? key, this.boldBottom = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyleBold = TextStyle(
        color: AppColors.greenDark, fontSize: 26, fontWeight: FontWeight.w900);
    const textStyle = TextStyle(color: AppColors.greenDark, fontSize: 21);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: boldBottom ? textStyle : textStyleBold,
        ),
        if (!boldBottom) const H(10),
        Text(
          subtitle,
          style: boldBottom ? textStyleBold : textStyle,
        ),
      ],
    );
  }
}
