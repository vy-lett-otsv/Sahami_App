import 'package:flutter/material.dart';
import '../constants/ui_color.dart';

class UITextInputIcon extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? color;
  final Color? colorCursor;
  final bool? isPassWordType;
  final TextEditingController? controller;

  const UITextInputIcon(
      {super.key,
      required this.text,
      this.icon,
      this.color = const Color(0xFF82AA06),
      this.colorCursor = const Color(0xFFD9D9D9),
      this.isPassWordType = false,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: UIColors.white,
            border: Border.all(color: UIColors.inputBackground)),
        padding: const EdgeInsets.only(left: 16, right: 4),
        child: TextField(
            controller: controller,
            cursorColor: colorCursor,
            obscureText: isPassWordType!,
            enableSuggestions: isPassWordType!,
            autocorrect: isPassWordType!,
            // textAlignVertical: TextAlignVertical.center,
            decoration: icon != null
                ? InputDecoration(
                    labelText: text,
                    prefixIcon: Icon(icon, color: color),
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.zero,
                  )
                : const InputDecoration(
                    border: InputBorder.none,
                  ),
            keyboardType: isPassWordType!
                ? TextInputType.visiblePassword
                : TextInputType.emailAddress));
  }
}
