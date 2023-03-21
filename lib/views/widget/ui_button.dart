import 'package:flutter/material.dart';

import '../../enums/fonts.dart';
import '../constants/dimens_manager.dart';
import '../constants/ui_color.dart';
class UIButton extends StatelessWidget {
  final String text;
  const UIButton ({super.key, required this.text});
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
                  vertical: DimensManager.dimens.setWidth(20)
              )),
              textStyle: MaterialStateProperty.all(
                  const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: Fonts.Outfit)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(20))
                  )
              )
          ),
          onPressed: () {},
          child: Text(text)),
    );
  }
}