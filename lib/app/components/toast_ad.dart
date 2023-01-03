import 'package:aid_brazil/app/components/stream_out.dart';
import 'package:aid_brazil/app/utils/utls_controller.dart';
import 'package:flutter/material.dart';

class ToastAd extends StatelessWidget {
  const ToastAd({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.9),
        ),
        child: Center(
          child: StreamOut<String>(
            stream: UtilsController().toastStream.listen,
            child: (_, toast) => Text(toast),
          ),
        ),
      ),
    );
  }
}
