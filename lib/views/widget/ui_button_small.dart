import 'package:flutter/material.dart';
import '../../enums/fonts.dart';
import '../constants/dimens_manager.dart';
import '../constants/ui_color.dart';

class UIButtonSmall extends StatelessWidget {
  final String text;
  final VoidCallback? onPress;

  const UIButtonSmall({super.key, this.onPress, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(UIColors.white),
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                horizontal: DimensManager.dimens.setWidth(20),
                vertical: DimensManager.dimens.setWidth(10))),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        DimensManager.dimens.setRadius(20))))),
        onPressed: onPress,
        child: Text(text,
            style: TextStyle(
                color: UIColors.text,
                fontFamily: Fonts.Outfit,
                fontWeight: FontWeight.normal,
                fontSize: 16)));
  }
}
