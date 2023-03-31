import 'package:flutter/material.dart';

import '../../enums/fonts.dart';
import '../constants/dimens_manager.dart';
import '../constants/ui_color.dart';

class UILabelTextInput extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final bool? notNull;
  final String? unit;

  const UILabelTextInput(
      {super.key, required this.title, this.controller, this.notNull = true, this.unit = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
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
            ),
             Text(unit!, style: TextStyle(
              color: UIColors.text,
              fontSize: 16,
              letterSpacing: 0.75,
              fontFamily: Fonts.Outfit,
              fontWeight: FontWeight.w400,
            ),)
          ],
        ),
        TextField(
          controller: controller,
          cursorColor: UIColors.text,
        )
      ],
    );
  }
}
