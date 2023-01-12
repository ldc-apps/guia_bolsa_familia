import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/h.dart';
import 'package:aid_brazil/app/modules/query/query_provider.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class QueryLoadingPage extends StatefulWidget {
  final String search;

  const QueryLoadingPage(this.search, {Key? key}) : super(key: key);

  @override
  State<QueryLoadingPage> createState() => _QueryLoadingPageState();
}

class _QueryLoadingPageState extends State<QueryLoadingPage> {
  @override
  void initState() {
    initMethod();
    super.initState();
  }

  Future<void> initMethod() async {
    QueryProvider().getBenefit(widget.search).then((response) {
      Future.delayed(const Duration(seconds: 3))
          .then((_) => Navigator.pop(context, response));
    });
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
                      'Consultando dados.',
                      style: TextStyle(
                          color: AppColors.greenDark,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    H(4),
                    Text(
                      'Depois do anúncio você verá o resultado.',
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
