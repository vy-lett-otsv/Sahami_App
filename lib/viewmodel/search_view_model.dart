import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahami_app/data/remote/entity/category_entity.dart';
import 'package:sahami_app/data/remote/entity/product_entity.dart';

class SearchViewModel extends ChangeNotifier {
  TextEditingController controller= TextEditingController();

  FocusNode focusNode = FocusNode();

  List<CategoryEntity> _categoryList = [];
  List<CategoryEntity> get categoryList => _categoryList;

  List<ProductEntity> _productList = [];
  List<ProductEntity> get productList => _productList;
  
  List<ProductEntity> _resultList = [];
  List<ProductEntity> get resultList => _resultList;


  var selectedRange = const RangeValues(0, 0);
  double rating = 0;

  void updateRating(RangeValues value) {
    selectedRange = value;
    notifyListeners();
  }

  Future<void> fetchCategory() async {
    final orderSnapshot = await FirebaseFirestore.instance
        .collection('category')
        .get();
    _categoryList = orderSnapshot.docs.map<CategoryEntity>((docSnapshot) {
      final data = docSnapshot.data();
      return CategoryEntity.fromJson(data);
    }).toList();
    notifyListeners();
  }

  Future<void> fetchProduct() async {
    final orderSnapshot = await FirebaseFirestore.instance
        .collection('product')
        .get();
    _productList = orderSnapshot.docs.map<ProductEntity>((docSnapshot) {
      final data = docSnapshot.data();
      return ProductEntity.fromJson(data);
    }).toList();
    notifyListeners();
  }


  Future<void> filterNameProduct(String name) async {
    await fetchProduct();
    print(productList.length);
    List<String> nameList = productList.map((product) => product.productName).toList();
    for (var item in nameList) {
      if(item.contains(name)) {
        final orderSnapshot = await FirebaseFirestore.instance
            .collection('product')
            .where('name', isEqualTo: item)
            .get();
        if (orderSnapshot.docs.isNotEmpty) {
          final data = orderSnapshot.docs.first.data();
          ProductEntity product = ProductEntity.fromJson(data);
          _resultList.add(product);
        }
      }
    }
    notifyListeners();
    print(resultList);

  }
}