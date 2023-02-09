import 'package:aid_brazil/app/components/module_page.dart';
import 'package:flutter/material.dart';

class RouteService {
  static String initial = '/';

  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (_) => ModulePage(),
  };
}
