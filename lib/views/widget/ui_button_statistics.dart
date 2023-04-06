import 'package:flutter/material.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import '../assets/asset_icons.dart';
import '../constants/ui_color.dart';
class UIButtonStatistics extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? image;
  const UIButtonStatistics({Key? key, this.icon, required this.title, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15
          ),
          decoration: BoxDecoration(
              color: UIColors.primarySecond,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  width: 1,
                  color: UIColors.text
              )
          ),
          child: image != null ?
          ImageIcon(AssetImage(image!),color: Colors.white, size: 40)
          : Icon(icon, color: Colors.white, size: 40),
        ),
        const SizedBox(height: 10),
        UIText(title, size: 12)
      ],
    );
  }
}
