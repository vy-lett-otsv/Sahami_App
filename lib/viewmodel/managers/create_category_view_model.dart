import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sahami_app/viewmodel/base_view_model.dart';
import '../../data/remote/entity/category_entity.dart';

class CreateCategoryViewModel extends BaseViewModel {
  List<CategoryEntity> _categories = [];

  List<CategoryEntity> get categories => _categories;

  void getAllCategory() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('category').orderBy('name').get();
    final cats = querySnapshot.docs.map((doc) => CategoryEntity.fromJson(doc.data())).toList();
    _categories = cats;
    notifyListeners();
  }

  void clearText(TextEditingController controllerName) {
    controllerName.clear();
  }

  Future<void> createCategory(CategoryEntity category, TextEditingController controllerName) async {
    final docCategory = FirebaseFirestore.instance.collection('category').doc();
    category.id = docCategory.id;
    final json = category.toJson();
    await docCategory.set(json);
    clearText(controllerName);
    getAllCategory();
  }

  Future<void> updateCategory(CategoryEntity category, String text) async {
    final docCategory = FirebaseFirestore.instance.collection('category').doc(category.id);
    await docCategory.update({'name': text});
    getAllCategory();
  }

  Future<void> deleteCategory(CategoryEntity category) async {
    final docCategory = FirebaseFirestore.instance.collection('category').doc(category.id);
    await docCategory.delete();
    getAllCategory();
  }

  // late final List<Map>

  // Future<CategoryEntity> fetchCategory(int index) async {
  //   return CategoryEntity.fromJson(categories[index]);
  // }

  ChangeNotifier a = ChangeNotifier();
}
