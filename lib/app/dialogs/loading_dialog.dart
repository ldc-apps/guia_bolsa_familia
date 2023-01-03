import 'package:aid_brazil/app/components/loading.dart';
import 'package:aid_brazil/app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.all(18),
        children: [
          Row(
            children: [
              const Loading(),
              const SizedBox(width: 18),
              Text('Carregando...', style: AppTheme.text.bodyText1)
            ],
          )
        ],
      ),
    );
  }
}
