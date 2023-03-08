import 'package:aid_brazil/app/components/button_icon.dart';
import 'package:flutter/material.dart';

class InFooterCta extends StatelessWidget {
  final void Function() onTap;
  final IconData icon;
  final String label;

  const InFooterCta({required this.onTap, required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEAEAEA),
      padding: const EdgeInsets.all(16),
      child: ButtonIcon(onTap: onTap, icon: icon, label: label),
    );
  }
}
