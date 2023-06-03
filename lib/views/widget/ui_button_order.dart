import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:sahami_app/views/widget/ui_title.dart';
import '../constants/dimens_manager.dart';
class UIButtonOrder extends StatelessWidget {
  final Callback callback;
  final Color? backgroundColor;
  final Color textColor;
  final String text;
  const UIButtonOrder({Key? key,
    required this.callback,
    this.backgroundColor = const Color(0xFF82AA06),
    this.textColor = Colors.white,
    required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: callback,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(
              vertical: DimensManager.dimens.setHeight(15),
              horizontal: DimensManager.dimens.setWidth(35),
            )),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(30)),
                )
            )
        ),
        child: UITitle(text, color: textColor,)
    );
  }
}
