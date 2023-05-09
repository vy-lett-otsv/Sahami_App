import 'package:flutter/material.dart';
import '../../enums/fonts.dart';
import '../constants/dimens_manager.dart';
import '../constants/ui_color.dart';

class UIButtonPrimary extends StatelessWidget {
  final String text;
  final VoidCallback? onPress;
  final double? size;
  final double paddingHorizontal;
  final double paddingVertical;
  final double radius;
  final bool light;

  const UIButtonPrimary(
      {super.key, this.onPress, this.size = 20, required this.text, this.paddingHorizontal = 80, this.paddingVertical = 15, this.radius = 30, this.light = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(light ? UIColors.primarySecond : UIColors.primary),
              padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                  horizontal: DimensManager.dimens.setWidth(paddingHorizontal),
                  vertical: DimensManager.dimens.setWidth(paddingVertical))),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          DimensManager.dimens.setRadius(radius))))),
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
