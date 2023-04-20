import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/viewmodel/category_view_model.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import 'package:sahami_app/views/widget/ui_textinput.dart';
import 'package:sahami_app/views/widget/ui_title.dart';
import '../../../data/remote/enitity/category_entity.dart';
import '../../../enums/fonts.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final _controllerName = TextEditingController();
  TextEditingController _controllerNameUpdate = TextEditingController();
  final CategoryViewModel _categoryViewModel = CategoryViewModel();
  final FocusNode _focusNode = FocusNode();

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
            title:
                const UITilte(UIStrings.manageCategory, color: UIColors.white),
            backgroundColor: UIColors.primary,
            centerTitle: true,
            leading: GestureDetector(
              child: const Icon(Icons.arrow_back_ios),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: DimensManager.dimens.setWidth(20),
                  vertical: DimensManager.dimens.setHeight(10)),
              child: Column(
                children: [
                  _buildAddCategory(),
                  SizedBox(height: DimensManager.dimens.setHeight(20)),
                  Consumer<CategoryViewModel>(builder: (_, category, __) {
                    //
                    return _buildListView(category);
                  })
                ],
              ))),
    );
  }

  Widget _buildAddCategory() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 7,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(DimensManager.dimens.setRadius(15)),
                  color: UIColors.white,
                  border: Border.all(color: UIColors.inputBackground),
                  boxShadow: [
                    BoxShadow(
                        color: UIColors.border,
                        blurRadius: 7,
                        offset: const Offset(2, 2))
                  ]),
              padding: EdgeInsets.only(
                  left: DimensManager.dimens.setWidth(15),
                  right: DimensManager.dimens.setWidth(4)),
              child: TextFormField(
                controller: _controllerName,
                focusNode: _focusNode,
                style: const TextStyle(
                  fontFamily: Fonts.Outfit,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: EdgeInsets.zero,
                ),
              )),
        ),
        Flexible(
            flex: 3,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(UIColors.primary),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        horizontal: DimensManager.dimens.setWidth(20),
                        vertical: DimensManager.dimens.setWidth(15))),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                DimensManager.dimens.setRadius(10))))),
                child: const UIText(UIStrings.create, color: UIColors.white),
                onPressed: () {
                  final category = CategoryEntity(categoryName: _controllerName.text);
                  _categoryViewModel.createCategory(category);
                  _focusNode.unfocus();
                  _controllerName.clear();
                }))
      ],
    );
  }

  Widget _buildListView(CategoryViewModel category) {
    return Expanded(
        child: ListView.builder(
            itemCount: category.categories.length,
            itemExtent: DimensManager.dimens.setHeight(80),
            itemBuilder: (context, index) {
              final itemCategory = category.categories[index];
              return ListTile(
                title: Text(itemCategory.categoryName),
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
            }));
  }

  Future<void> _buildDialogEdit(BuildContext context,
      CategoryEntity itemCategory, CategoryViewModel category) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(DimensManager.dimens.setRadius(20))),
            ),
            content: UITextInput(
                textDisplay: itemCategory.categoryName,
                colorCursor: UIColors.black,
                controller: _controllerNameUpdate,
                color: UIColors.black),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, '');
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: UIColors.white),
                child: UIText(UIStrings.cancel, color: UIColors.primary),
              ),
              ElevatedButton(
                onPressed: () {
                  category.updateCategory(
                      itemCategory, _controllerNameUpdate.text);
                  Navigator.pop(context, '');
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: UIColors.primary),
                child: const UIText(UIStrings.ok, color: UIColors.white),
              )
            ],
          );
        });
  }

  Future<void> _buildDialogDelete(
      CategoryViewModel category, CategoryEntity itemCategory) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(DimensManager.dimens.setRadius(20))),
              ),
              title: const UITilte(UIStrings.titleConfirm),
              content: const UIText(UIStrings.confirmDelete),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, '');
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: UIColors.white),
                  child: UIText(UIStrings.cancel, color: UIColors.primary),
                ),
                ElevatedButton(
                  onPressed: () {
                    category.deleteCategory(itemCategory);
                    Navigator.pop(context, '');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: UIColors.primary),
                  child: const UIText(UIStrings.ok, color: UIColors.white),
                )
              ],
            ));
  }
}
