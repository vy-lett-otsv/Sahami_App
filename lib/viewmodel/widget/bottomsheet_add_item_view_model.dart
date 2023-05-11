import 'package:flutter/material.dart';
import '../../data/data_local.dart';
import '../../data/remote/enitity/option_entity.dart';

class BottomSheetAddItemViewModel extends ChangeNotifier {
  bool _isSelectedItem = false;
  bool get isSelectedItem => _isSelectedItem;

  int brownSugarSyrup = 0;
  int caramelSyrup = 0;
  int vanillaSyrup = 0;

  // List<OptionEntity> _optionList =[];
  // List<OptionEntity> get userOption => _optionList;
  //
  OptionEntity _optionEntity = OptionEntity();
  OptionEntity get optionEntity => _optionEntity;

  int _quantity = 0;
  int get quantity => _quantity;

  // int _initCartItems = 0;
  // int get initCartItems => _initCartItems + _quantity;

  // set quantityBrownSugarSyrup(int quantity) {
  //   if(quantity > 0) {
  //     _optionEntity.brownSugarSyrup = quantity;
  //   } else {
  //     _optionEntity.brownSugarSyrup = null;
  //   }
  //   notifyListeners();
  // }
  //
  // set quantityCaramelSyrup(int quantity) {
  //   if(quantity > 0) {
  //     _optionEntity.caramelSyrup = quantity;
  //   } else {
  //     _optionEntity.caramelSyrup = null;
  //   }
  //   notifyListeners();
  // }
  //
  // set quantityVanillaSyrup(int quantity) {
  //   if(quantity > 0) {
  //     _optionEntity.vanillaSyrup = quantity;
  //   } else {
  //     _optionEntity.vanillaSyrup = null;
  //   }
  //   notifyListeners();
  // }

  int? quantitySyrup() {
    if(quantity > 0) {
      return quantity;
    } else {
      return null;
    }
  }

  void addProductList() {
    _optionEntity = OptionEntity(
      brownSugarSyrup: brownSugarSyrup,
      caramelSyrup: caramelSyrup,
      vanillaSyrup: vanillaSyrup,
    );
    print(_optionEntity);
  }

  void setQuantity(bool isIncrement, bool? isBrownSugarSyrup, bool? isCaramelSyrup, bool? isVanillaSyrup) {
    if(isIncrement) {
      if(isBrownSugarSyrup == true) {
        brownSugarSyrup = checkQuantity(brownSugarSyrup+1);
      }
      if(isCaramelSyrup == true) {
        caramelSyrup = checkQuantity(caramelSyrup+1);
      }
      if(isVanillaSyrup == true) {
        vanillaSyrup = checkQuantity(vanillaSyrup+1);
      }
    } else {
      if(isBrownSugarSyrup == true) {
        brownSugarSyrup = checkQuantity(brownSugarSyrup-1);
      }
      if(isCaramelSyrup == true) {
        caramelSyrup = checkQuantity(caramelSyrup-1);
      }
      if(isVanillaSyrup == true) {
        vanillaSyrup = checkQuantity(vanillaSyrup-1);
      }
    }
    print("Quantity view model $quantity}");
  }

  int checkQuantity(int quantity) {
    if(quantity<0) {
      return 0;
    } else if (quantity > 10) {
      return 10;
    } else {
      return quantity;
    }
  }

  void updateSelectedSize(int index) {
    int currentIndex = DataLocal.cupSize.indexWhere((item) => item.isSelected);
    if (currentIndex != index) {
      DataLocal.cupSize[currentIndex].isSelected = false;
      DataLocal.cupSize[index].isSelected = true;
      notifyListeners();
    }
    print("updateSelectedSize $currentIndex");
  }

  void initProduct() {
    _quantity = 0;
    // _initCartItems = 0;
  }

  String valueIce = "";

  void selected(String name) {
    if(name=="brownSugarSyrup") {
      brownSugarSyrup = 1;
    }
    if(name=="caramelSyrup") {
      caramelSyrup = 1;
    }
    if(name=="vanillaSyrup") {
      vanillaSyrup = 1;
    }
    _isSelectedItem = true;
    notifyListeners();
  }

  // void resetAddPump() {
  //   _isSelectedItem = false;
  // }

  // void removeQuantity(String name) {
  //   if(name=="brownSugarSyrup") {
  //     brownSugarSyrup -= 1;
  //   }
  //   if(name=="caramelSyrup") {
  //     caramelSyrup -= 1;
  //   }
  //   if(name=="vanillaSyrup") {
  //     vanillaSyrup -= 1;
  //   }
  //   notifyListeners();
  // }
  //
  // void addQuantity(String name) {
  //   if(name=="brownSugarSyrup") {
  //     brownSugarSyrup += 1;
  //   }
  //   if(name=="caramelSyrup") {
  //     caramelSyrup += 1;
  //   }
  //   if(name=="vanillaSyrup") {
  //     vanillaSyrup += 1;
  //   }
  //   notifyListeners();
  // }
}