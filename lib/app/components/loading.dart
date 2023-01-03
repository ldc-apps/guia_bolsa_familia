import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final Color color;

  const Loading({Key? key, this.color = AppColors.greenDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 40,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}
