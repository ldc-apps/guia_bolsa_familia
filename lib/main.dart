import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/ad/ad_controller.dart';
import 'app/app_widget.dart';
import 'app/services/connectivity_service.dart';
import 'app/services/foreground_service.dart';
import 'app/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  await Firebase.initializeApp();
  await AdController.initAdConfig();
  initFirebaseMessaging();
  await setupFlutterNotifications();
  await ConnectivyService.init();
  await ForegroundService.listen();
  await initializeDateFormatting('pt_BR');
  runApp(const App());
}
