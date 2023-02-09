import 'package:flutter/material.dart';

class BannerTransparent extends StatelessWidget {
  const BannerTransparent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 42),
      height: 250,
      width: 300,
      color: Colors.grey,
    );
  }
}
