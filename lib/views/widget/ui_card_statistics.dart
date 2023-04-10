import 'package:flutter/material.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/widget/ui_title.dart';
import '../constants/ui_color.dart';

class UICardStatistics extends StatelessWidget {
  final String title;
  final String data;

  const UICardStatistics({Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: UIColors.primary),
            borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: UITilte(title, size: 14),
              ),
              SizedBox(
                height: DimensManager.dimens.setHeight(10),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: UITilte(data, size: 24, fontWeight: FontWeight.w800),
              )
            ],
          ),
        ));
  }
}
