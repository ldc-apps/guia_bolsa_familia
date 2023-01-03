import 'package:aid_brazil/app/components/w.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:aid_brazil/app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class Field extends StatefulWidget {
  final dynamic controller;
  final String label;
  final String hint;
  final String? prefix;
  final String? counter;
  final String? helper;
  final bool obscure;
  final bool enable;
  final IconData? icon;
  final TextInputType type;
  final TextInputAction? action;
  final void Function()? onTapIcon;
  final void Function()? onTapCounter;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focus;
  final FocusNode? nextFocus;
  final int flex;

  const Field(
      {Key? key,
      required this.controller,
      required this.label,
      this.hint = '',
      this.obscure = false,
      this.icon,
      this.onTapIcon,
      this.onTapCounter,
      this.type = TextInputType.visiblePassword,
      this.onChange,
      this.prefix,
      this.counter,
      this.enable = true,
      this.action,
      this.onSubmitted,
      this.focus,
      this.nextFocus,
      this.helper,
      this.flex = 0})
      : super(key: key);

  @override
  FieldState createState() => FieldState();
}

class FieldState extends State<Field> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final field = IgnorePointer(
        ignoring: !widget.enable,
        child: Container(
          color: widget.enable ? null : AppColors.disable.withOpacity(0.1),
          padding: widget.enable ? null : const EdgeInsets.all(8),
          child: Theme(
            data: ThemeData(
              colorScheme: AppTheme.theme.colorScheme.copyWith(
                primary: AppColors.grey,
              ),
            ),
            child: TextField(
              controller: widget.controller,
              style: AppTheme.text.bodyText1!
                  .copyWith(fontSize: 30, fontWeight: FontWeight.w500),
              cursorColor: AppColors.grey,
              obscureText: widget.obscure,
              keyboardType: widget.type,
              onChanged: widget.onChange,
              textInputAction: widget.action,
              onSubmitted: widget.onSubmitted,
              focusNode: widget.focus,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixText: widget.prefix,
                  prefixStyle: AppTheme.text.bodyText1!
                      .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
                  isDense: true,
                  labelText: widget.label,
                  labelStyle: AppTheme.text.bodyText1!.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey),
                  hintText: widget.hint,
                  hintStyle: AppTheme.text.bodyText1!.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey.withOpacity(0.3)),
                  helperText: widget.helper,
                  helperStyle: AppTheme.text.bodyText1!.copyWith(
                      fontSize: 30, color: AppColors.grey.withOpacity(0.6)),
                  counter: widget.counter == null
                      ? null
                      : GestureDetector(
                          onTap: widget.onTapCounter ?? () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(widget.counter!,
                                  style: AppTheme.text.bodyText1!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              const W(2),
                              Icon(Icons.arrow_forward_ios_rounded,
                                  color: AppColors.grey, size: 14)
                            ],
                          ),
                        ),
                  floatingLabelStyle: AppTheme.text.bodyText1!.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w500, height: 0.99),
                  contentPadding: const EdgeInsets.all(8),
                  suffixIcon: widget.icon == null
                      ? null
                      : GestureDetector(
                          onTap: widget.onTapIcon ?? () {},
                          child: Icon(
                            widget.icon,
                            size: 32,
                            color: AppColors.greenDark,
                          ),
                        ),
                  focusedBorder: _border(),
                  border: _border()),
            ),
          ),
        ),
      );

      return widget.flex == 0
          ? Container(child: field)
          : Expanded(flex: widget.flex, child: field);
    });
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.grey, width: 2),
    );
  }
}
