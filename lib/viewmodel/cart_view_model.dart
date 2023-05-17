import 'package:flutter/cupertino.dart';

import '../services/cart_service.dart';

class CartViewModel extends ChangeNotifier{
  Map<dynamic, dynamic> updatedElement = Map();

  void displayTextOptionItem(int index) {
    var selectedElement = CartService().orderList[index];
    updatedElement = Map.from(selectedElement)
      ..remove('image')
      ..remove('price')
      ..remove('priceSale')
      ..remove('name_product')
      ..remove('quantity');
    print(updatedElement);
  }


  Map<String, dynamic> getNamedSyrup() => {
    'size': updatedElement['size'],
    if (updatedElement.containsKey('ice')) 'ice': updatedElement['ice'],
    if (updatedElement.containsKey('sugar')) 'sugar': updatedElement['sugar'],
    if (updatedElement.containsKey('brown_sugar_syrup')) 'brown_sugar_syrup': 'Thêm ${updatedElement['brown_sugar_syrup']} pump si rô brown sugar',
    if (updatedElement.containsKey('caramel_syrup')) 'caramelSyrup': 'Thêm ${updatedElement['caramel_syrup']} pump si rô caramel',
    if (updatedElement.containsKey('vanilla_syrup')) 'vanillaSyrup': 'Thêm ${updatedElement['vanilla_syrup']} pump si rô vanilla',
    if (updatedElement.containsKey('cookie_crumble_topping')) 'cookie_crumble_topping': updatedElement['cookie_crumble_topping'],
  };
}