import 'package:flutter/material.dart';

class UIColors {
  UIColors._();
  static final Color primary = HexColor.fromHex("#82AA06");
  static final Color text = HexColor.fromHex("#6E6E6E");
  static final Color star = HexColor.fromHex("#F7DC69");
  static final Color label = HexColor.fromHex("#F2F2FF");
  static final Color borderError = HexColor.fromHex("#F23E3E").withOpacity(0.8);
  static final Color errorMessage = HexColor.fromHex("#F23E3E");
  static final Color lightRed = HexColor.fromHex("#FCA896");
  static final Color red = HexColor.fromHex("#D52731");
  static final Color primarySecond = HexColor.fromHex("#A0C743");
  static final Color border = HexColor.fromHex("#D9D9D9");
  static final Color yellow = HexColor.fromHex("#f9ca24");
  static final Color textDart = HexColor.fromHex("#2f3640");


  static final Color backgroundBottom = HexColor.fromHex("#E5E5E5");
  static final Color backgroundInput = HexColor.fromHex("#D9D9D9");
  static final Color background = HexColor.fromHex("#F3F4F6");
  static final Color primaryBackground = HexColor.fromHex("#F4F4F5");

  static const Color black = Colors.black;
  static const Color white = Colors.white;
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    Color color = Colors.black;
    try {
      color = Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {}
    return color;
  }
}

