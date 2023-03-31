import 'package:flutter/material.dart';
import '../../enums/fonts.dart';
import '../constants/ui_color.dart';
class UILabel extends StatelessWidget {
  final String title;
  final bool? notNull;
  const UILabel(
      {super.key, required this.title, this.notNull = true});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text.rich(TextSpan(
          text: title,
          style: const TextStyle(
            color: UIColors.black,
            fontSize: 16,
            letterSpacing: 0.75,
            fontFamily: Fonts.Outfit,
            fontWeight: FontWeight.w400,
          ),
          children: <InlineSpan>[
            notNull == true
                ? TextSpan(
                text: ' *',
                style: TextStyle(
                  color: UIColors.red,
                  fontSize: 16,
                  letterSpacing: 0.75,
                  fontFamily: Fonts.Outfit,
                  fontWeight: FontWeight.w400,
                ))
                : const TextSpan(
              text: '',
            )
          ])),
    );
  }
}
