import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/viewmodel/category_view_model.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import 'package:sahami_app/views/widget/ui_textinput.dart';
import 'package:sahami_app/views/widget/ui_title.dart';
import '../../../../data/remote/entity/category_entity.dart';
import '../../../../enums/fonts.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final CategoryViewModel _categoryViewModel = CategoryViewModel();

  @override
  void initState() {
    super.initState();
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
          title: const UITitle(UIStrings.manageCategory, color: UIColors.white),
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
          child: Consumer<CategoryViewModel>(
            builder: (_, categoryViewModel, __) {
              return Column(
                children: [
                  _buildAddCategory(categoryViewModel),
                  SizedBox(height: DimensManager.dimens.setHeight(20)),
                  _buildListView(categoryViewModel)
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAddCategory(CategoryViewModel categoryViewModel) {
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
              border: Border.all(color: UIColors.backgroundInput),
              boxShadow: [
                BoxShadow(
                  color: UIColors.border,
                  blurRadius: 7,
                  offset: const Offset(2, 2),
                )
              ],
            ),
            padding: EdgeInsets.only(
                left: DimensManager.dimens.setWidth(15),
                right: DimensManager.dimens.setWidth(4)),
            child: TextFormField(
              controller: categoryViewModel.controllerName,
              focusNode: categoryViewModel.focusNode,
              style: const TextStyle(
                fontFamily: Fonts.Outfit,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(UIColors.primary),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                    horizontal: DimensManager.dimens.setWidth(20),
                    vertical: DimensManager.dimens.setWidth(15))),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            DimensManager.dimens.setRadius(10))))),
            child: const UIText(UIStrings.create, color: UIColors.white),
            onPressed: () {
              categoryViewModel.addCategory();
            },
          ),
        )
      ],
    );
  }

  Widget _buildListView(CategoryViewModel categoryViewModel) {
    return Expanded(
        child: ListView.builder(
            itemCount: categoryViewModel.categories.length,
            itemExtent: DimensManager.dimens.setHeight(80),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(categoryViewModel.categories[index].categoryName),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _buildDialogEdit(
                            context,
                            categoryViewModel.categories[index],
                            categoryViewModel);
                      },
                      child: Icon(
                        Icons.edit,
                        color: UIColors.star,
                      ),
                    ),
                    SizedBox(width: DimensManager.dimens.setWidth(20)),
                    GestureDetector(
                      onTap: () => _buildDialogDelete(categoryViewModel,
                          categoryViewModel.categories[index]),
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
      CategoryEntity itemCategory, CategoryViewModel categoryViewModel) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  DimensManager.dimens.setRadius(20),
                ),
              ),
            ),
            content: UITextInput(
                textDisplay: itemCategory.categoryName,
                colorCursor: UIColors.black,
                controller: categoryViewModel.controllerNameUpdate,
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
                  categoryViewModel.updateCategory(itemCategory,
                      categoryViewModel.controllerNameUpdate.text);
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
            Radius.circular(
              DimensManager.dimens.setRadius(20),
            ),
          ),
        ),
        title: const UITitle(UIStrings.titleConfirm),
        content: const UIText(UIStrings.confirmDelete),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, '');
            },
            style: ElevatedButton.styleFrom(backgroundColor: UIColors.white),
            child: UIText(UIStrings.cancel, color: UIColors.primary),
          ),
          ElevatedButton(
            onPressed: () {
              category.deleteCategory(itemCategory);
              Navigator.pop(context, '');
            },
            style: ElevatedButton.styleFrom(backgroundColor: UIColors.primary),
            child: const UIText(UIStrings.ok, color: UIColors.white),
          )
        ],
      ),
    );
  }
}
