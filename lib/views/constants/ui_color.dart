import 'package:flutter/material.dart';

class UIColors {
  UIColors._();
  static final Color primary = HexColor.fromHex("#82AA06");
  static final Color inputBackground = HexColor.fromHex("#D9D9D9");
  static final Color background = HexColor.fromHex("#F9F9FB");
  static final Color text = HexColor.fromHex("#6E6E6E");
  static final Color star = HexColor.fromHex("#F7DC69");
  static final Color label = HexColor.fromHex("#F2F2FF");
  static final Color borderError = HexColor.fromHex("#F23E3E").withOpacity(0.8);
  static final Color errorMessage = HexColor.fromHex("#F23E3E");
  static final Color lightRed = HexColor.fromHex("#FCA896");
  static final Color red = HexColor.fromHex("#D52731");

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

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

