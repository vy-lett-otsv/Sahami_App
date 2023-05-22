import 'package:flutter/material.dart';
import '../views/assets/asset_icons.dart';

class DataLocal {
  static List<IconCupSize> cupSize = [
    IconCupSize(image: AssetIcons.iconCupSizeM, name: "Size M", price: 0, isSelected: true),
    IconCupSize(image: AssetIcons.iconCupSizeM, name: "Size L", price: 10000, isSelected: false),
    IconCupSize(image: AssetIcons.iconCupSizeM, name: "Size XL", price: 20000, isSelected: false)
  ];

  static const List<Tab> productTabs = <Tab>[
    Tab(text: 'Mô tả'),
    Tab(text: 'Thông tin'),
    Tab(text: 'Bình luận'),
  ];

  static const List<String> ice = ["Bình thường", "Nhiều đá", "Ít đá", "Không đá"];
  static const List<String> sugar = ["Bình thường", "Nhiều đường", "Ít đường", "Không đường"];
  static const List<String> cookieCrumbleTopping = ["Cookie Crumble Topping", "Nhiều Cookie Crumble Topping", "Không Cookie Crumble Topping", "Substitute Cookie Crumble Topping"];

  static List<DeliveryOption> deliveryOption = [
    DeliveryOption(name: "Giao hàng tận nơi", price: "15,000 VNĐ", isSelected: true),
    DeliveryOption(name: "Nhận tại cửa hàng", price: "Free", isSelected: false),
  ];
}

class IconCupSize {
  String image;
  String name;
  double price;
  bool isSelected;

  IconCupSize({required this.image, required this.name, required this.price, required this.isSelected});

  IconCupSize clone(
      {String? image, String? name, double? price, bool? isSelected}
      ){
    return IconCupSize(image: image??this.image, name: name??this.name, price: price??this.price, isSelected: isSelected??this.isSelected);
  }
}

class DeliveryOption {
  String name;
  String price;
  bool isSelected;

  DeliveryOption({required this.name, required this.price, required this.isSelected});
}