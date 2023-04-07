import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sahami_app/viewmodel/base_view_model.dart';
import 'package:sahami_app/views/widget/bottomsheet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/remote/entity/category_entity.dart';

class CreateCategoryViewModel extends BaseViewModel {

  List<CategoryEntity> _categories = [];
  List<CategoryEntity> get categories => _categories;

  int _selectedCategory = 0;
  int get selectedCategory => _selectedCategory;

  void getAllCategory() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('category')
        .orderBy('name')
        .get();
    final cats = querySnapshot.docs
        .map((doc) => CategoryEntity.fromJson(doc.data()))
        .toList();
    _categories = cats;
    notifyListeners();
  }

  void clearText(TextEditingController controllerName) {
    controllerName.clear();
  }

  Future<void> createCategory(CategoryEntity category) async {
    final docCategory = FirebaseFirestore.instance.collection('category').doc();
    category.categoryId = docCategory.id;
    final json = category.toJson();
    await docCategory.set(json);
    getAllCategory();
  }


  Future<void> updateCategory(CategoryEntity category, String text) async {
    final docCategory = FirebaseFirestore.instance
        .collection('category')
        .doc(category.categoryId);
    await docCategory.update({'name': text});
    getAllCategory();
  }

  Future<void> deleteCategory(CategoryEntity category) async {
    final docCategory = FirebaseFirestore.instance
        .collection('category')
        .doc(category.categoryId);
    await docCategory.delete();
    getAllCategory();
  }


}
