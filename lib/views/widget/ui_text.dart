import 'package:flutter/material.dart';
import '../../enums/fonts.dart';


class UIText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final bool? softWrap;
  final Color color;
  final double size;
  final TextDecoration decoration;
  final FontWeight fontWeight;

  UIText(
      this.text, {
        Key? key,
        this.style,
        this.strutStyle,
        this.maxLines,
        this.textAlign,
        this.overflow,
        this.softWrap,
        this.color =  const Color(0xFF6E6E6E),
        this.size = 16,
        this.decoration = TextDecoration.none,
        this.fontWeight = FontWeight.w400,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaleFactor: 1.0,
      maxLines: maxLines,
      style: TextStyle(
          color: color,
          fontSize: size,
          letterSpacing: 0.75,
          fontFamily: Fonts.Outfit,
          fontWeight: fontWeight,
          height: 1.25,
          decoration: decoration
      ).merge(style),
      strutStyle: strutStyle,
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
    );
  }
}


