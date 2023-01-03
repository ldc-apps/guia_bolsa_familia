import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class BannerLoading extends StatelessWidget {
  const BannerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 42),
      height: 250,
      color: Colors.grey[100],
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color?>(AppColors.green),
        ),
      ),
    );
  }
}


