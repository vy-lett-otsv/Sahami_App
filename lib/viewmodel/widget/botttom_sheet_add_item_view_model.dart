import 'package:flutter/material.dart';
import 'package:sahami_app/data/remote/entity/product_entity.dart';
import 'package:sahami_app/services/cart_service.dart';
import '../../data/data_local.dart';
import '../../data/remote/entity/option_entity.dart';

class BottomSheetAddItemViewModel extends ChangeNotifier {
  OptionEntity _optionEntity = OptionEntity(nameProduct: "", price: 0.0, priceSale: 0.0, image: "");
  OptionEntity get optionEntity => _optionEntity;

  String dropdownValue = DataLocal.ice.first;

  bool isSelected = false;

  bool isDisplay = true;

  double total = 0;

  void addProductList(ProductEntity productEntity, BuildContext context) {
    _optionEntity = OptionEntity(
      nameProduct: productEntity.productName,
      price: productEntity.price,
      priceSale: productEntity.priceSale,
      image: productEntity.image,
      size: DataLocal.cupSize[indexSize].name,
      ice: _optionEntity.ice,
      sugar: _optionEntity.sugar,
      brownSugarSyrup: _optionEntity.brownSugarSyrup,
      caramelSyrup: _optionEntity.caramelSyrup,
      vanillaSyrup: _optionEntity.vanillaSyrup,
      cookieCrumbleTopping: _optionEntity.cookieCrumbleTopping,
      quantity: _optionEntity.quantity,
      total: productEntity.priceSale != 0 ? (productEntity.priceSale + DataLocal.cupSize[indexSize].price) * _optionEntity.quantity : (productEntity.price + DataLocal.cupSize[indexSize].price) * _optionEntity.quantity
    );
    print(_optionEntity.toJson());
    CartService().orderList.add(_optionEntity.toJson());
    CartService().total();
    notifyListeners();

    Navigator.pop(context);
  }


  int checkQuantity(int quantity) {
    if(quantity<1) {
      isSelected = false;
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

  late int _currentIndex;
  int get currentIndex => _currentIndex;

  int indexSize = 0;

  void updateSelectedSize(int index) {
    print(index);
    _currentIndex = DataLocal.cupSize.indexWhere((item) => item.isSelected);
    if (_currentIndex != index) {
      DataLocal.cupSize[_currentIndex].isSelected = false;
      DataLocal.cupSize[index].isSelected = true;
      notifyListeners();
    }
    indexSize = index;
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
    updateSelectedSize(0);
    _optionEntity.ice = DataLocal.ice.first;
    _optionEntity.sugar = DataLocal.sugar.first;
    _optionEntity.brownSugarSyrup = 0;
    _optionEntity.caramelSyrup = 0;
    _optionEntity.vanillaSyrup = 0;
    _optionEntity.cookieCrumbleTopping = DataLocal.cookieCrumbleTopping.first;
    notifyListeners();
  }
}