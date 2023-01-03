import 'package:aid_brazil/app/dialogs/loading_dialog.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static showLoadingDialog([BuildContext? context]) {
    context ??= contextGlobal;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          FocusManager.instance.primaryFocus!.unfocus();
          return const LoadingDialog();
        });
  }

  static Future<dynamic> showAppDialog(
      BuildContext context, Widget widget) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          FocusManager.instance.primaryFocus!.unfocus();
          return widget;
        });
  }

  // static showCounterDialog(BuildContext context){
  //   showDialog(context: context, barrierDismissible: false, builder: (_){
  //     FocusManager.instance.primaryFocus!.unfocus();
  //     return CounterDialog();
  //   });
  // }
}
