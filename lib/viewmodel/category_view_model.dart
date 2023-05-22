import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../data/remote/entity/category_entity.dart';

class CategoryViewModel extends ChangeNotifier {

  List<CategoryEntity> _categories = [];
  List<CategoryEntity> get categories => _categories;

  final int _selectedCategory = 0;
  int get selectedCategory => _selectedCategory;

  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerNameUpdate = TextEditingController();
  final FocusNode focusNode = FocusNode();

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

  void addCategory() {
    final category = CategoryEntity(categoryName: controllerName.text);
    createCategory(category);
    focusNode.unfocus();
    controllerName.clear();
  }
}