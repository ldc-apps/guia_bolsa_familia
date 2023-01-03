import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
                child: SizedBox(
              width: 246,
              height: 246,
              child: Image.asset('assets/images/loading.gif'),
            )),
            SizedBox(
                width: 200,
                height: 200,
                child: Image.asset('assets/images/logo.png')),
          ],
        ),
      ),
    );
  }
}
