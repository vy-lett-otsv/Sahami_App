import 'package:flutter/material.dart';
import '../constants/dimens_manager.dart';

class UIIconButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double radius;
  final VoidCallback? onPressed;
  final bool circle;

  const UIIconButton(
      {Key? key,
      required this.icon,
      this.backgroundColor = const Color(0xFFFFFDF6),
      this.iconColor = const Color(0xFF6E6E6E),
      this.radius = 36,
      this.onPressed,
      this.circle = true
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(circle ? radius / 2: 10),
            color: backgroundColor),
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          icon: Icon(icon,
              color: iconColor, size: DimensManager.dimens.setSp(24)),
        ));
  }
}
