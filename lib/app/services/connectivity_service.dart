import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/rxdart.dart';

class ConnectivyService {
  static final Connectivity _connectivity = Connectivity();

  static final BehaviorSubject<bool> connectionController =
      BehaviorSubject<bool>();
  static Sink<bool> get inResult => connectionController.sink;
  static Stream<bool> get outResult => connectionController.stream;
  static bool get hasConnection => connectionController.stream.hasValue
      ? connectionController.stream.value
      : false;

  static Future<void> init() async {
    inResult.add(await getConnectiviy);
    _connectivity.onConnectivityChanged
        .listen((event) => inResult.add(event != ConnectivityResult.none));
    Timer.periodic(const Duration(seconds: 3), (timer) async {
      if (!connectionController.stream.value) return;
      try {
        final result = await InternetAddress.lookup('www.kindacode.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          inResult.add(true);
        }
      } on SocketException catch (_) {
        inResult.add(false);
      }
    });
  }

  static Future<bool> get getConnectiviy async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
