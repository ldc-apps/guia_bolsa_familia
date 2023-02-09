import 'package:aid_brazil/app/components/splash_page.dart';
import 'package:aid_brazil/app/components/stream_out.dart';
import 'package:aid_brazil/app/enums/module_enum.dart';
import 'package:aid_brazil/app/modules/home/ui/home_page.dart';
import 'package:aid_brazil/app/utils/utls_controller.dart';
import 'package:flutter/material.dart';

class ModulePage extends StatelessWidget {
  ModulePage({Key? key}) : super(key: key);

  final UtilsController _utilsController = UtilsController();

  @override
  Widget build(BuildContext context) {
    return StreamOut<bool>(
      stream: _utilsController.ignoringStream.listen,
      child: (_, ignoring) => IgnorePointer(
        ignoring: ignoring,
        child: StreamOut(
          stream: _utilsController.moduleStream.listen,
          child: (_, module) =>
              module == Module.home ? const HomePage() : const SplashPage(),
        ),
      ),
    );
  }
}
