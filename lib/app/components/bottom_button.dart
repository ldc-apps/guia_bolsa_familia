import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function() function;

  const BottomButton(this.label, this.icon, this.function, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
            color: AppColors.greenDark,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )),
        padding: const EdgeInsets.all(20),
        child: InkWell(
          onTap: function,
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.greenLight,
            ),
            width: double.maxFinite,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    label,
                    style: const TextStyle(
                        color: AppColors.greenDark,
                        fontSize: 18,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    icon,
                    color: AppColors.greenDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
