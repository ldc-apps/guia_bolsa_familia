import 'package:aid_brazil/app/components/app_scaffold.dart';
import 'package:aid_brazil/app/components/back.dart';
import 'package:aid_brazil/app/components/background_gradient.dart';
import 'package:aid_brazil/app/modules/new/new_model.dart';
import 'package:aid_brazil/app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  final New work;

  const NewPage(this.work, {Key? key}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ContainerBackground(
            height: 160,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const Back(
                  label: 'Notícias',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 54),
                  child: Text(
                    widget.work.title,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 54, vertical: 12),
                  child: Text(
                    widget.work.subtitle,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body(context),
        ],
      ),
    );
  }

  Widget body(_) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: Text(
        widget.work.title,
        style: const TextStyle(color: Color(0xFF727272)),
      ),
    );
  }
}
