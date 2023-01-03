import 'package:aid_brazil/app/enums/module_enum.dart';
import 'package:aid_brazil/app/models/app_stream.dart';
import 'package:flutter/material.dart';

class UtilsController {
  static final UtilsController _utilsController = UtilsController._();

  UtilsController._();

  factory UtilsController() => _utilsController;

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  final AppStream<bool> ignoringStream = AppStream<bool>.seed(false);

  final AppStream<Module> moduleStream = AppStream<Module>.seed(Module.splash);

  final AppStream<String> toastStream = AppStream<String>.seed('');
}
