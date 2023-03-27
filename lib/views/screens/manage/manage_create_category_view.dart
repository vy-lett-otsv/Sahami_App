import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_button.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import 'package:sahami_app/views/widget/ui_textinput.dart';
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
  final controllerName = TextEditingController();
  final controllerNameUpdate = TextEditingController();
  final CreateCategoryViewModel _createCategoryViewModel =
      CreateCategoryViewModel();

  void clearText() {
    controllerName.clear();
  }

  @override
  void initState() {
    super.initState();
    DimensManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: UITilte(UIStrings.manageCategory, color: UIColors.white)),
          backgroundColor: UIColors.primary,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: DimensManager.dimens.setWidth(20)),
          child: Column(
            children: [
              SizedBox(height: DimensManager.dimens.setHeight(20)),
              Row(
                children: [
                  Expanded(
                      child: UITextInput(controller: controllerName, text: "")),
                  SizedBox(width: DimensManager.dimens.setWidth(10)),
                  UIButton(
                    text: UIStrings.add,
                    size: DimensManager.dimens.setHeight(18),
                    onPress: () {
                      final category =
                          CategoryEntity(name: controllerName.text);
                      _createCategoryViewModel.createCategory(category);
                      clearText();
                    },
                  )
                ],
              ),
              SizedBox(height: DimensManager.dimens.setHeight(20)),
              Expanded(
                child: StreamBuilder<List<CategoryEntity>>(
                  stream: _createCategoryViewModel.readCategory(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong! ${snapshot.hasError}');
                    } else if (snapshot.hasData) {
                      final categories = snapshot.data!;
                      return ListView(
                        children: categories.map(buildCategory).toList(),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }

  Widget buildCategory(CategoryEntity category) => ListTile(
      visualDensity: VisualDensity(vertical: DimensManager.dimens.setHeight(5)),
      title: Text(category.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(
                              DimensManager.dimens.setRadius(20))),
                        ),
                        content: UITextInput(
                            text: category.name,
                            controller: controllerNameUpdate,
                            colorCusor: UIColors.black),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              _createCategoryViewModel.updateCategory(
                                  category, controllerNameUpdate.text);
                              Navigator.pop(context, 'Update');
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: UIColors.primary),
                            child: UIText('OK', color: UIColors.white),
                          ),
                        ],
                      ));
            },
            child: Icon(
              Icons.edit,
              color: UIColors.star,
            ),
          ),
          SizedBox(width: DimensManager.dimens.setWidth(20)),
          GestureDetector(
            onTap: () {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(
                              DimensManager.dimens.setRadius(20))),
                        ),
                        title: const UITilte('Are you sure?'),
                        content: UIText(
                            'Do you really want to delete these records? This process cannot be undone.'),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: UIColors.white,
                                side: BorderSide(
                                    width: 1.0, color: UIColors.primary)),
                            child: UIText('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              final docCat = FirebaseFirestore.instance
                                  .collection('category')
                                  .doc(category.id);
                              docCat.delete();
                              Navigator.pop(context, 'OK');
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: UIColors.primary),
                            child: UIText('OK', color: UIColors.white),
                          ),
                        ],
                      ));
            },
            child: Icon(
              Icons.delete,
              color: UIColors.lightRed,
            ),
          )
        ],
      ));
}
