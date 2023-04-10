import 'dart:math';
import 'dimens/base_dimens.dart';

class Dimens extends BaseDimens {
  double paddingBottom = 0.0;

  @override
  void initialDimens() {
    print("Dimens initialDimens");
    paddingBottom = max(indicatorBarHeight, 16);
  }
}


