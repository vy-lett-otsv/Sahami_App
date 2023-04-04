import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sahami_app/viewmodel/base_view_model.dart';
import 'package:sahami_app/views/widget/bottomsheet_model.dart';
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
    category.categoryId = docCategory.id;
    final json = category.toJson();
    await docCategory.set(json);
    clearText(controllerName);
    getAllCategory();
  }

  Future<void> updateCategory(CategoryEntity category, String text) async {
    final docCategory = FirebaseFirestore.instance.collection('category').doc(category.categoryId);
    await docCategory.update({'name': text});
    getAllCategory();
  }

  Future<void> deleteCategory(CategoryEntity category) async {
    final docCategory = FirebaseFirestore.instance.collection('category').doc(category.categoryId);
    await docCategory.delete();
    getAllCategory();
  }

  Future<CategoryEntity> fetchCategory(int index) async{
    final querySnapshot = await FirebaseFirestore.instance.collection('category').orderBy('name').get();
    final cats = querySnapshot.docs.map((doc) => CategoryEntity.fromJson(doc.data())).toList().elementAt(index);
    return cats;
  }

  CategoryEntity? _category;
  CategoryEntity? get category => _category;


  int selectedButton = 0;
  var _selectedCategoryId = " ";
  get selectedCategoryId => _selectedCategoryId;
  String _selectedCategoryName = " ";
  String get selectedCategoryName => _selectedCategoryName;

  void setSelectedCategory(int? index) {
    selectedButton = index?? selectedButton;
    final categoryIndex = categories[index!];
    _selectedCategoryId = categoryIndex.categoryId;
    _selectedCategoryName = categoryIndex.categoryName;
    // updateUI();
    notifyListeners();
  }




  bool hasSubmitted = false;
  @override
  void onInitView(BuildContext context) {
    super.onInitView(context);
    hasSubmitted = false;
    getAllCategory();
  }

  CategoryEntity? _selected;
  bool _filterAll = false;
  bool get filterAll => _filterAll;
  void initializeCategory(CategoryEntity? entity) {
    _selected = entity;
    _filterAll = (_selected == null);
  }

  // final itemCategory = categories.elementAt(index);



}
