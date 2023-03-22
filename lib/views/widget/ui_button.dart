import 'package:flutter/material.dart';

import '../../enums/fonts.dart';
import '../constants/dimens_manager.dart';
import '../constants/ui_color.dart';
class UIButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPress;
  final double? size;
  const UIButton ({super.key,
    this.onPress,
    this.size = 20,
    required this.text
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(UIColors.primary),
              padding:
              MaterialStateProperty.all(EdgeInsets.symmetric(
                  horizontal: DimensManager.dimens.setWidth(50),
                  vertical: DimensManager.dimens.setWidth(15)
              )),
              textStyle: MaterialStateProperty.all(
                  TextStyle(
                      fontSize: size,
                      color: Colors.white,
                      fontFamily: Fonts.Outfit)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(20))
                  )
              )
          ),
          onPressed: onPress,
          child: Text(text)),
    );
  }
}