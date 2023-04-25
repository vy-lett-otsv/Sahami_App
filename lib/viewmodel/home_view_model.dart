import 'package:flutter/material.dart';
import '../views/constants/dimens_manager.dart';

class HomeViewModel extends ChangeNotifier {
  final double _height = (DimensManager.dimens.fullHeight) / 6.5;

  var currPageValue = 0.0;
  final double _scaleFactor = 0.8;

  Matrix4 _matrix = Matrix4.identity();

  Matrix4 get matrix => _matrix;

  PageController pageController = PageController(viewportFraction: 0.9); //Phần nhỏ của khung nhìn mà mỗi trang sẽ chiếm.

  void matrixSlide(int index) {
    if (index == currPageValue.floor()) {
      var currScale = 1 - (currPageValue - index) * (1 - _scaleFactor);
      var curTrans = _height * (1 - currScale) / 2;
      _matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, curTrans, 0);
    } else if (index == currPageValue.floor() + 1) {
      var currScale = _scaleFactor + (currPageValue - index + 1) * (1 - _scaleFactor);
      var curTrans = _height * (1 - currScale) / 2; //220*(1-0.8)/2 = 220*0.2/2 = 220*1/10 = 22
      _matrix = Matrix4.diagonal3Values(1, currScale, 1);
      _matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, curTrans, 0);
    } else if (index == currPageValue.floor() - 1) {
      var currScale = 1 - (currPageValue - index) * (1 - _scaleFactor);
      var curTrans = _height * (1 - currScale) / 2;
      _matrix = Matrix4.diagonal3Values(1, currScale, 1);
      _matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, curTrans, 0);
    } else {
      var currScale = 0.8;
      _matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }
  }

  void pageControllerView() {
    pageController.addListener(() {
      currPageValue = pageController.page!;
      notifyListeners();
    });
  }
}
