import 'package:flutter/material.dart';
import '../constants/ui_color.dart';

class UITextInput extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? color;
  const UITextInput({
    super.key,
    required this.text,
    required this.icon,
    this.color = const Color(0xFF82AA06)});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: UIColors.white,
            border: Border.all(
                color: UIColors.inputBackground
            )
        ),
        padding: const EdgeInsets.only(
            left: 16,
            right: 4
        ),
        child: TextField(
          decoration: InputDecoration(
            labelText: text,
            prefixIcon: Icon(icon, color: color),
            border: InputBorder.none,
          ),
        )
    );
  }
}