import 'package:flutter/material.dart';
import 'package:sahami_app/views/widget/ui_text.dart';

import '../constants/dimens_manager.dart';
import '../constants/ui_color.dart';
class UILabelTextInputIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  const UILabelTextInputIcon({Key? key, required this.title, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.teal,
      padding: EdgeInsets.only(
        bottom: DimensManager.dimens.setHeight(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIText(title),
          SizedBox(height: DimensManager.dimens.setHeight(10)),
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: UIColors.primary),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(30)),
                  borderSide: BorderSide(
                      width: 1, color: UIColors.border
                  )
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(30)),
                  borderSide: BorderSide(
                      width: 1, color: UIColors.border
                  )
              ),
              filled: true,
              fillColor: UIColors.white,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          )
        ],
      ),
    );
  }
}
