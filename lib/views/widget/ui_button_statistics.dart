import 'package:flutter/material.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import '../constants/ui_color.dart';

class UIButtonStatistics extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? image;
  final Function() onTap;
  const UIButtonStatistics({Key? key,
    this.icon,
    required this.title,
    this.image,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: DimensManager.dimens.setWidth(10),
                vertical: DimensManager.dimens.setHeight(10)
            ),
            decoration: BoxDecoration(
                color: UIColors.primarySecond,
                borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(20)),
                border: Border.all(
                    width: 2,
                    color: UIColors.primary
                )
            ),
            child: image != null ?
            ImageIcon(AssetImage(image!),color: Colors.white, size: 40)
            : Icon(icon, color: Colors.white, size: 40),
          ),
          SizedBox(height: DimensManager.dimens.setHeight(10)),
          UIText(title, size: 10)
        ],
      ),
    );
  }
}
