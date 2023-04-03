import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_button_primary.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import 'package:sahami_app/views/widget/ui_textinput.dart';
import 'package:sahami_app/views/widget/ui_textinput_icon.dart';
import 'package:sahami_app/views/widget/ui_title.dart';

import '../../../data/remote/entity/category_entity.dart';
import '../../../viewmodel/managers/create_category_view_model.dart';

class ManageCreateCategoryView extends StatefulWidget {
  const ManageCreateCategoryView({Key? key}) : super(key: key);

  @override
  State<ManageCreateCategoryView> createState() =>
      _ManageCreateCategoryViewState();
}

class _ManageCreateCategoryViewState extends State<ManageCreateCategoryView> {
  final _controllerName = TextEditingController();
  TextEditingController _controllerNameUpdate = TextEditingController();
  final CreateCategoryViewModel _categoryViewModel = CreateCategoryViewModel();

  @override
  void initState() {
    super.initState();
    DimensManager();
    _categoryViewModel.getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _categoryViewModel),
      ],
      child: Scaffold(
          backgroundColor: UIColors.background,
          appBar: AppBar(
            title: const Center(
                child:
                UITilte(UIStrings.manageCategory, color: UIColors.white)),
            backgroundColor: UIColors.primary,
          ),
          body: Container(
            padding: EdgeInsets.symmetric(
                horizontal: DimensManager.dimens.setWidth(20),
              vertical: DimensManager.dimens.setHeight(10)
            ),
            child: Column(
              children: [
                _buildAddCategory(),
                SizedBox(height: DimensManager.dimens.setHeight(20)),
                Consumer<CreateCategoryViewModel>(
                    builder: (_, category, __) {//
                      return  _buildListView(category);
                    }
                )
              ],
            )
          )),
    );
  }

  Widget _buildAddCategory() {
    return Row(
      children: [
        Expanded(child: UITextInputIcon(controller: _controllerName, text: "")),
        SizedBox(width: DimensManager.dimens.setWidth(10)),
        UIButtonPrimary(
          text: UIStrings.add,
          size: DimensManager.dimens.setHeight(18),
          onPress: () {
            final category = CategoryEntity(name: _controllerName.text);
            _categoryViewModel.createCategory(category, _controllerName);
            FocusManager.instance.primaryFocus?.unfocus();
          },
        )
      ],
    );
  }

  Widget _buildListView(CreateCategoryViewModel category) {
    return Expanded(
        child: ListView.builder(
            itemCount: category.categories.length,
            itemExtent: 80,
            itemBuilder: (context, index) {
              final itemCategory = category.categories[index];
              return ListTile(
                title: Text(itemCategory.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _buildDialogEdit(context, itemCategory, category);
                        _controllerNameUpdate = TextEditingController();
                        },
                      child: Icon(
                        Icons.edit,
                        color: UIColors.star,
                      ),
                    ),
                    SizedBox(width: DimensManager.dimens.setWidth(20)),
                    GestureDetector(
                      onTap: () => _buildDialogDelete(category, itemCategory),
                      child: Icon(
                        Icons.delete,
                        color: UIColors.lightRed,
                      ),
                    )
                  ],
                ),
              );
            }
        )
    );
  }

  Future<void> _buildDialogEdit(BuildContext context, CategoryEntity itemCategory, CreateCategoryViewModel category) {
    print(itemCategory.name);
    // print(_controllerNameUpdate.text);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(DimensManager.dimens.setRadius(20))),
            ),
            content:
            UITextInput(textDisplay: itemCategory.name, colorCursor: UIColors.black, controller: _controllerNameUpdate, color: UIColors.black),
            // UITextInput(text: itemCategory.name, colorCursor: UIColors.black, color: UIColors.black),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, '');
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: UIColors.white
                ),
                child: UIText(UIStrings.cancel, color: UIColors.primary),
              ),
              ElevatedButton(
                onPressed: () {
                  category.updateCategory(itemCategory, _controllerNameUpdate.text);
                  Navigator.pop(context, '');
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: UIColors.primary
                ),
                child: const UIText(UIStrings.ok, color: UIColors.white),
              )
            ],
          );
        }
    );
  }

  Future<void> _buildDialogDelete(CreateCategoryViewModel category, CategoryEntity itemCategory) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(DimensManager.dimens.setRadius(20))),
          ),
          title: const UITilte(UIStrings.titleConfirm),
          content: const UIText(UIStrings.confirmDelete),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, '');
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: UIColors.white
              ),
              child: UIText(UIStrings.cancel, color: UIColors.primary),
            ),
            ElevatedButton(
              onPressed: () {
                category.deleteCategory(itemCategory);
                Navigator.pop(context, '');
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: UIColors.primary
              ),
              child: const UIText(UIStrings.ok, color: UIColors.white),
            )
          ],
        )
    );
  }
}
