import 'package:flutter/material.dart';

class ProductDetailViewModel extends ChangeNotifier{
  int _currentProductTab = 0;

  bool _favorite = false;
  bool get favorite => _favorite;

  void changeStaffTab(productTab) {
    _currentProductTab = productTab;
  }

  void setFavorite() {
    _favorite = !_favorite;
    notifyListeners();
  }

  void updateUI() {
    notifyListeners();
  }
}