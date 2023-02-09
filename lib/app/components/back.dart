import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class Back extends StatelessWidget {
  final String? label;
  final Function()? onTap;
  final Color color;
  final double margin;
  final Widget? action;

  const Back(
      {this.label,
      this.onTap,
      Key? key,
      this.color = Colors.black26,
      this.action,
      this.margin = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (onTap != null) {
              onTap!.call();
            } else {
              Navigator.pop(context);
            }
          },
          child: Container(
            margin: EdgeInsets.all(margin),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(6),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.greenLight,
              size: 24,
            ),
          ),
        ),
        const Spacer(),
        if (action != null) action!
      ],
    );
  }
}
