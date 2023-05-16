import 'package:flutter/cupertino.dart';

import '../services/cart_service.dart';

class CartViewModel extends ChangeNotifier{
  String option = "";


  void displayTextOptionItem(int index) {
    final item = CartService().orderList[index];
    if(item.ice == "Bình thường") {
      option = "Size ${item.size}, ${item.sugar}, "
          "Thêm ${item.brownSugarSyrup} pump si rô brown sugar";
      if(item.sugar == "Bình thường") {
        option = "Size ${item.size}, ${item.sugar}";
      }
    }
  }
}