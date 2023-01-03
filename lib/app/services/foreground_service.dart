import 'package:aid_brazil/app/ad/ad_controller.dart';
import 'package:aid_brazil/app/components/splash_page.dart';
import 'package:aid_brazil/app/enums/module_enum.dart';
import 'package:aid_brazil/app/models/app_stream.dart';
import 'package:aid_brazil/app/utils/global_resource.dart';
import 'package:aid_brazil/app/utils/utls_controller.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';

class ForegroundService {
  static AppStream<bool> foregroundStream = AppStream.seed(true);

  static bool showForegroundBack = false;
  static bool appReturnFromWebExec = false;

  static listen() {
    foregroundStream.add(true);
    FGBGEvents.stream.listen((fg) async {
      foregroundStream.add(fg == FGBGType.foreground);
      if (fg == FGBGType.foreground) {
        if (appReturnFromWebExec) {
          appReturnFromWebExec = false;
          return;
        }
        if (showForegroundBack) {
          UtilsController().moduleStream.add(Module.splash);
          push(contextGlobal, const SplashPage());
          AdController.fetchOpenedAppAd(AdController.adConfig.appOpen.id,
              fromBackground: true);
        }
      }
    });
  }
}
