import 'package:flutter/material.dart';
import 'package:aid_brazil/app/components/module_page.dart';

class RouteService {
  static String initial = '/';

  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (_) => ModulePage(),
  };
}
