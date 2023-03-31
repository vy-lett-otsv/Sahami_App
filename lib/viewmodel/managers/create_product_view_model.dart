import 'dart:html';
import 'dart:ui';

import 'package:sahami_app/data/remote/entity/category_entity.dart';
import 'package:sahami_app/viewmodel/managers/create_category_view_model.dart';

import '../base_view_model.dart';

class CreateProductViewModel extends BaseViewModel{
  final CreateCategoryViewModel categoryViewModel = CreateCategoryViewModel();
  late int selectedButton;
  late TextStyle? _style;
  late CategoryEntity _categoryEntity;
  late int liked;
  int get totalResponses => categoryViewModel.categories.length;



  TextStyle get style => _style ?? TextStyle();

  CreateProductViewModel() {
    selectedButton = 0;
    liked = 0;
    _categoryEntity = CategoryEntity(name: ' ');

  }

  void setSelectedButton(int? index) async {
    selectedButton = index ?? selectedButton;

  }
}