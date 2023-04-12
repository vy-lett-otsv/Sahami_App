import 'package:flutter/material.dart';
import '../../enums/fonts.dart';
import '../constants/dimens_manager.dart';
import '../constants/ui_color.dart';

class UIButtonPrimary extends StatelessWidget {
  final String text;
  final VoidCallback? onPress;
  final double? size;

  const UIButtonPrimary(
      {super.key, this.onPress, this.size = 20, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(UIColors.primary),
              padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                  horizontal: DimensManager.dimens.setWidth(80),
                  vertical: DimensManager.dimens.setWidth(15))),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          DimensManager.dimens.setRadius(30))))),
          onPressed: onPress,
          child: Text(text,
              style: const TextStyle(
                  color: UIColors.white,
                  fontFamily: Fonts.Outfit,
                  fontWeight: FontWeight.bold,
                  fontSize: 16))),
    );
  }
}
