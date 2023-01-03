import 'package:flutter/material.dart';

class AppController {
  static final AppController _appController = AppController._();

  AppController._();

  factory AppController() => _appController;

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  BuildContext get context => key.currentState!.context;
}
