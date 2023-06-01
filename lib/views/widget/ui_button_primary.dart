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
  final Color textColor;
  final Color backgroundColor;
  final bool isBorder;

  const UIButtonPrimary(
      {super.key,
      this.onPress,
      this.size = 20,
      required this.text,
      this.paddingHorizontal = 80,
      this.paddingVertical = 15,
      this.radius = 30,
      this.textColor = const Color(0xFFFFFFFF),
      this.backgroundColor = const Color(0xFF82AA06),
      this.isBorder = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                horizontal: DimensManager.dimens.setWidth(paddingHorizontal),
                vertical: DimensManager.dimens.setHeight(paddingVertical))),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              isBorder ? RoundedRectangleBorder(
                side: BorderSide(color: UIColors.primary, width: 1),
                borderRadius: BorderRadius.circular(
                  DimensManager.dimens.setRadius(radius),
                ),
              ) :
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  DimensManager.dimens.setRadius(radius),
                ),
              ),
            ),
          ),
          onPressed: onPress,
          child: Text(text,
              style: TextStyle(
                  color: textColor,
                  fontFamily: Fonts.Inter,
                  fontWeight: isBorder ? FontWeight.normal : FontWeight.bold,
                  fontSize: 16))),
    );
  }
}
