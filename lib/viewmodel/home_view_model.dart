import 'package:flutter/material.dart';
import 'package:sahami_app/views/screens/home/user/search_view.dart';
import '../views/constants/dimens_manager.dart';

class HomeViewModel extends ChangeNotifier {
  final double _height = (DimensManager.dimens.fullHeight) / 6.5;

  var currPageValue = 0.0;
  final double _scaleFactor = 0.8;

  Matrix4 _matrix = Matrix4.identity();

  Matrix4 get matrix => _matrix;

  PageController pageController = PageController(viewportFraction: 0.9); //Phần nhỏ của khung nhìn mà mỗi trang sẽ chiếm.

  TextEditingController controller= TextEditingController();

  FocusNode focusNode = FocusNode();

  void navigateSearchView(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SearchView()));
  }

  void matrixSlide(int index) {
    double currentScale, currentTrans;

    if (index == currPageValue.floor()) {
      currentScale = 1 - (currPageValue - index) * (1 - _scaleFactor);
    } else if (index == currPageValue.floor() + 1) {
      currentScale = _scaleFactor + (currPageValue - index + 1) * (1 - _scaleFactor);
    } else if (index == currPageValue.floor() - 1) {
      currentScale = 1 - (currPageValue-index)*(1-_scaleFactor);
    }
    else {
      currentScale = 0.8;
    }

    currentTrans = _height * (1 - currentScale) / 2;
    _matrix = Matrix4.diagonal3Values(1, currentScale, 1);
    _matrix.setTranslationRaw(0, currentTrans, 0);
  }

  void pageControllerView() {
    pageController.addListener(() {
      currPageValue = pageController.page!;
      notifyListeners();
    });
  }
}
