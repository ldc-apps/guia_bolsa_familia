import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/enums/fill.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final Color color;
  final Color? textColor;
  final Fill fill;
  final String? valid;
  final bool removeWarningText;
  final Widget? child;
  final double? padding;

  const Button(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.child,
      this.color = const Color(0xFF9FC131),
      this.fill = Fill.filled,
      this.valid = empty,
      this.textColor = Colors.white,
      this.padding = 8,
      this.removeWarningText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool filled = fill == Fill.filled;
    return Column(
      children: [
        TextButton(
            onPressed: valid == empty ? onPressed : null,
            style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                minimumSize: MaterialStateProperty.all<Size>(
                    const Size(double.maxFinite, 38)),
                backgroundColor: MaterialStateProperty.all<Color>(filled
                    ? valid != empty || onPressed == null
                        ? AppColors.disable
                        : color
                    : Colors.transparent),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 26, vertical: padding!)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                )),
            child: child ??
                Text(label, style: TextStyle(fontSize: 18, color: textColor))),
        if (!removeWarningText)
          if (valid != null)
            if (valid != empty) const H(8),
        if (!removeWarningText)
          if (valid != null)
            if (valid != empty)
              Container(
                  alignment: Alignment.center,
                  child: Text(valid!,
                      style: TextStyle(
                          color: AppColors.red, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center)),
      ],
    );
  }
}
