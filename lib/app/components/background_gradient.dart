import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ContainerBackground extends StatelessWidget {
  final Widget? child;
  final double height;

  const ContainerBackground({this.child, this.height = 180, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: AppColors.greenDark,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: child,
    );
  }
}
