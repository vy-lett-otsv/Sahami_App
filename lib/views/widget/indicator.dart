import 'package:flutter/material.dart';
import 'package:sahami_app/data/fake_data.dart';

import '../constants/dimens_manager.dart';

class Indicator extends StatelessWidget {
  const Indicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: FakeData.dataPiechart.map((data) => Container(
        child: buildIndicator(
          color: data.color,
          text: data.name,
        ),
      )).toList(),
    );
  }

  Widget buildIndicator({
    required Color color,
    required String text,
    double size = 16,
    Color textColor = const Color(0xff505050),
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: DimensManager.dimens.setHeight(5)),
      child: Row(
        children: <Widget>[
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(5))
            ),
          ),
          SizedBox(width: DimensManager.dimens.setHeight(10)),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          )
        ],
      ),
    );
  }
}
