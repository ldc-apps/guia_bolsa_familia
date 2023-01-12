import 'package:aid_brazil/app/ad/ad_controller.dart';
import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class QuizLoadingPage extends StatefulWidget {
  const QuizLoadingPage({Key? key}) : super(key: key);

  @override
  State<QuizLoadingPage> createState() => _QuizLoadingPageState();
}

class _QuizLoadingPageState extends State<QuizLoadingPage> {
  @override
  void initState() {
    initMethod();
    super.initState();
  }

  Future<void> initMethod() async {
    await Future.delayed(const Duration(seconds: 3));
    await AdController.checkAndshowQueryAd(onComplete: () => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AppScaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 180),
                    child: Image.asset('assets/images/searching.gif'),
                  )),
              Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    H(84),
                    Text(
                      'Carregando dados.',
                      style: TextStyle(
                          color: AppColors.greenDark,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    H(4),
                    Text(
                      'Iniciando Quiz após exibição do anúncio.',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
