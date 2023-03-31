import 'package:flutter/material.dart';

class UITextInput extends StatelessWidget {
  final String textDisplay;
  final Color? color;
  final Color? colorCursor;
  final bool? isPassWordType;
  final TextEditingController? controller;

  const UITextInput(
      {super.key,
        required this.textDisplay,
        this.color = const Color(0xFF82AA06),
        this.colorCursor = const Color(0xFFFFFFFF),
        this.isPassWordType = false,
        this.controller
      });

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        cursorColor: colorCursor,
        obscureText: isPassWordType!,
        enableSuggestions: isPassWordType!,
        autocorrect: isPassWordType!,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          labelText: textDisplay,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: const EdgeInsets.only(left: 10),
        ),
        expands: true,
        keyboardType: isPassWordType!
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress);
  }
}
