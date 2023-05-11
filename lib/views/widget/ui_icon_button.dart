import 'package:flutter/material.dart';
import '../constants/dimens_manager.dart';

class UIIconButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final VoidCallback? onPressed;

  const UIIconButton(
      {Key? key,
      required this.icon,
      this.backgroundColor = const Color(0xFFFFFDF6),
      this.iconColor = const Color(0xFF6E6E6E),
      this.size = 36,
        this.onPressed
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: backgroundColor
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(icon, color: iconColor, size: DimensManager.dimens.setSp(24)),
      )
    );
  }
}
