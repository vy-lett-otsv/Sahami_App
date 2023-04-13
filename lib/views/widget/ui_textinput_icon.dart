import 'package:flutter/material.dart';
import '../../enums/fonts.dart';
import '../constants/ui_color.dart';

class UITextInputIcon extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? color;
  final Color? colorCursor;
  final bool? isPassWordType;
  final TextEditingController? controller;
  final FormFieldValidator? validation;
  final Widget? suffixIcon;

  const UITextInputIcon(
      {super.key,
      required this.text,
      this.icon,
      this.color = const Color(0xFF82AA06),
      this.colorCursor = const Color(0xFFD9D9D9),
      this.isPassWordType = false,
      this.controller,
      this.validation,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: UIColors.white,
            border: Border.all(color: UIColors.inputBackground),
            boxShadow: [
              BoxShadow(
                  color: UIColors.border,
                  blurRadius: 7,
                  offset: const Offset(2, 2))
            ]),
        padding: const EdgeInsets.only(left: 16, right: 4),
        child: TextFormField(
            controller: controller,
            cursorColor: colorCursor,
            obscureText: isPassWordType!,
            enableSuggestions: isPassWordType!,
            autocorrect: isPassWordType!,
            style: const TextStyle(
              fontFamily: Fonts.Outfit,
            ),
            validator: validation,
            decoration: InputDecoration(
              labelText: text,
              prefixIcon: Icon(icon, color: color),
              border: InputBorder.none,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: EdgeInsets.zero,
              suffixIcon: suffixIcon
            ),
            keyboardType: isPassWordType!
                ? TextInputType.visiblePassword
                : TextInputType.emailAddress));
  }
}
