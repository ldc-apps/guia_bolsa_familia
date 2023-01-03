import 'package:aid_brazil/app/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

BuildContext get contextGlobal => AppController().key.currentState!.context;

const String empty = '';

void pops(BuildContext context, int length) {
  for (var i = 0; i < length; i++) {
    Navigator.pop(context);
  }
}

void pop([BuildContext? context]) => Navigator.pop(context ?? contextGlobal);

// AppLocalizations get T => AppLocalizations.of(contextGlobal)!;

DateTime? parsePeriod(String? period) => period != null
    ? DateTime(
        int.parse(period.split('-').last), int.parse(period.split('-')[1]), 0)
    : null;

String doubleToCurrency(double? value) {
  if (value == null) return '-';
  return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
}

dynamic push(BuildContext context, Widget widget) async {
  var result =
      await Navigator.push(context, MaterialPageRoute(builder: (_) => widget));
  return result;
}

AppLocalizations get T => AppLocalizations.of(contextGlobal)!;
