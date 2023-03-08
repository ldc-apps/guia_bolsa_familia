import 'package:aid_brazil/app/components/w.dart';
import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  final void Function() onTap;
  final IconData icon;
  final String label;

  const ButtonIcon({required this.onTap, required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFF0C5C0A),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28,
              color: const Color(0xFFFFFFFF),
            ),
            const W(12),
            Container(
              margin: const EdgeInsets.only(bottom: 6),
              child: Text(
                label,
                style: TextStyle(
        fontSize: 18,
        height: 1.5,
        fontWeight: FontWeight.bold,
        fontFamily: 'Inter',
        color: Color(0xFFFFFFFF),
      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
