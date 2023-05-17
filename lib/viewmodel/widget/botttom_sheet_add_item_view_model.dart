import 'package:flutter/material.dart';
import 'package:sahami_app/data/remote/enitity/product_entity.dart';
import 'package:sahami_app/services/cart_service.dart';
import '../../data/data_local.dart';
import '../../data/remote/enitity/option_entity.dart';

class BottomSheetAddItemViewModel extends ChangeNotifier {
  OptionEntity _optionEntity = OptionEntity(nameProduct: "", price: 0.0, priceSale: 0.0, image: "");
  OptionEntity get optionEntity => _optionEntity;

  String nameSize = DataLocal.cupSize[0].name;


  String dropdownValue = DataLocal.ice.first;

  bool isSelected = false;

  bool isDisplay = true;

  void addProductList(ProductEntity productEntity, BuildContext context) {
    _optionEntity = OptionEntity(
      nameProduct: productEntity.productName,
      price: productEntity.price,
      priceSale: productEntity.priceSale,
      image: productEntity.image,
      size: nameSize,
      ice: _optionEntity.ice,
      sugar: _optionEntity.sugar,
      brownSugarSyrup: _optionEntity.brownSugarSyrup,
      caramelSyrup: _optionEntity.caramelSyrup,
      vanillaSyrup: _optionEntity.vanillaSyrup,
      cookieCrumbleTopping: _optionEntity.cookieCrumbleTopping,
      quantity: _optionEntity.quantity
    );

    CartService().orderList.add(_optionEntity.toJson());
    CartService().totalCartItem();
    notifyListeners();

    Navigator.pop(context);
  }


  int checkQuantity(int quantity) {
    if(quantity<1) {
      return 1;
    } else if (quantity >10) {
      return 10;
    } else {
      return quantity;
    }
  }

  void setQuantity(bool isIncrement) {
    isSelected = true;
    if(isIncrement) {
      _optionEntity.quantity = checkQuantity(_optionEntity.quantity + 1);
    } else {
      _optionEntity.quantity = checkQuantity(_optionEntity.quantity - 1);
    }
    notifyListeners();
  }

  void setQuantityBrownSugarSyrup(bool isIncrement) {
    isSelected = true;
    if(isIncrement) {
      _optionEntity.brownSugarSyrup = checkQuantity(_optionEntity.brownSugarSyrup + 1);
    } else {
      _optionEntity.brownSugarSyrup = checkQuantity(_optionEntity.brownSugarSyrup - 1);
    }
    notifyListeners();
  }

  void setQuantityCaramelSyrup(bool isIncrement) {
    isSelected = true;
    if(isIncrement) {
      _optionEntity.caramelSyrup = checkQuantity(_optionEntity.caramelSyrup + 1);
    } else {
      _optionEntity.caramelSyrup = checkQuantity(_optionEntity.caramelSyrup - 1);
    }
    notifyListeners();
  }

  void setQuantityVanillaSyrup(bool isIncrement) {
    isSelected = true;
    if(isIncrement) {
      _optionEntity.vanillaSyrup = checkQuantity(_optionEntity.vanillaSyrup + 1);
    } else {
      _optionEntity.vanillaSyrup = checkQuantity(_optionEntity.vanillaSyrup - 1);
    }
    notifyListeners();
  }

  void updateSelectedSize(int index, String name) {
    int currentIndex = DataLocal.cupSize.indexWhere((item) => item.isSelected);
    if (currentIndex != index) {
      DataLocal.cupSize[currentIndex].isSelected = false;
      DataLocal.cupSize[index].isSelected = true;
      notifyListeners();
    }
    nameSize = name;
  }

  void setIce(String? value) {
    isSelected = true;
    if(value!=null) {
      dropdownValue = value;
      _optionEntity.ice = value;
    }
    notifyListeners();
  }

  void setSugar(String? value) {
    isSelected = true;
    if(value!=null) {
      dropdownValue = value;
      _optionEntity.sugar = value;
    }
    notifyListeners();
  }
  void setCookieCrumbleTopping(String? value) {
    isSelected = true;
    if(value!=null) {
      dropdownValue = value;
      _optionEntity.cookieCrumbleTopping = value;
    }
    notifyListeners();
  }

  void initProduct() {
    isSelected = false;
    updateSelectedSize(0, nameSize);
    _optionEntity.ice = DataLocal.ice.first;
    _optionEntity.sugar = DataLocal.sugar.first;
    _optionEntity.brownSugarSyrup = 0;
    _optionEntity.caramelSyrup = 0;
    _optionEntity.vanillaSyrup = 0;
    _optionEntity.cookieCrumbleTopping = DataLocal.cookieCrumbleTopping.first;
    notifyListeners();
  }
}