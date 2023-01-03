import 'package:aid_brazil/app/components/background_gradient.dart';
import 'package:flutter/material.dart';

class CommonHeader extends StatelessWidget {
  final Widget top;
  final Widget child;
  final double height;

  const CommonHeader(
      {Key? key, required this.top, required this.child, this.height = 270})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: height,
      child: Stack(
        children: [
          const ContainerBackground(),
          child,
          top,
        ],
      ),
    );
  }
}
