import 'package:flutter/material.dart';
import '../views/assets/asset_icons.dart';

class DataLocal {
  static List<IconCupSize> cupSize = [
    IconCupSize(image: AssetIcons.iconCupSizeM, price: "0", isSelected: true),
    IconCupSize(image: AssetIcons.iconCupSizeM, price: "10,000", isSelected: false),
    IconCupSize(image: AssetIcons.iconCupSizeM, price: "20,000", isSelected: false)
  ];

  static const List<Tab> productTabs = <Tab>[
    Tab(text: 'Mô tả'),
    Tab(text: 'Thông tin'),
    Tab(text: 'Bình luận'),
  ];

  static const List<String> ice = ["Bình thường", "Nhiều đá", "Ít đá", "Không đá"];
  static const List<String> sugar = ["Bình thường", "Nhiều đường", "Ít đường", "Không đường"];
}

class IconCupSize {
  String image;
  String price;
  bool isSelected;

  IconCupSize({required this.image, required this.price, required this.isSelected});
}