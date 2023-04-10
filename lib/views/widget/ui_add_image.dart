import 'package:flutter/material.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import '../assets/asset_icons.dart';
import '../constants/dimens_manager.dart';
import '../constants/ui_color.dart';
import '../constants/ui_strings.dart';

class UIAddImage extends StatelessWidget {
  final Function() onTap;
  const UIAddImage({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: DimensManager.dimens.setWidth(10)),
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(DimensManager.dimens.setRadius(10)),
          color: UIColors.white,
        ),
        height: DimensManager.dimens.setHeight(70),
        child: Row(
          children: [
            Image.asset(AssetIcons.iconAddImage,
                width: DimensManager.dimens.setWidth(50)),
            SizedBox(
              width: DimensManager.dimens.setWidth(10),
            ),
            const UIText(UIStrings.addNewImage)
          ],
        ),
      ),
    );
  }
}