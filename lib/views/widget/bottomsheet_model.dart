import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/data/remote/entity/category_entity.dart';
import 'package:sahami_app/viewmodel/managers/create_category_view_model.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/widget/ui_title.dart';
import '../constants/ui_color.dart';
import '../constants/ui_strings.dart';

class BottomSheetDialog {
  static ShapeBorder shape =  RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DimensManager.dimens.setWidth(20)),
          topRight: Radius.circular(DimensManager.dimens.setWidth(20)),
      )
  );

  static Future<void> showCategoryDialog({
    required BuildContext context,
    CategoryEntity? entity,
    Function(CategoryEntity?)? onSelectCategory,
  }) {
    CreateCategoryViewModel dialogViewModel = CreateCategoryViewModel()
    ..onInitView(context)
    ..initializeCategory(entity);
    return showModalBottomSheet<CategoryEntity?>(
        shape: shape,
        context: context,
        builder: (_) {
          return FractionallySizedBox(
            heightFactor: 0.8,
            child: ChangeNotifierProvider.value(
                value: dialogViewModel,
              child: Consumer<CreateCategoryViewModel>(
                builder: (_, category, __) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: DimensManager.dimens.setHeight(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.keyboard_arrow_left_rounded, size: 24),
                            ),
                            const UITilte(UIStrings.category),
                            const SizedBox(width: 44),
                          ],
                        ),
                      ),
                      Divider(color: UIColors.text),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: category.categories.length,
                            itemBuilder: (context, index) {
                              final itemCategory = category.categories[index];
                              return RadioListTile(
                                controlAffinity: ListTileControlAffinity.trailing,
                                groupValue: category.selectedButton,
                                title: Text(itemCategory.name),
                                onChanged: (value) {
                                  category.setSelectedCategory(value);
                                  print("Hi ${itemCategory.id}");
                                },
                                value: index,
                              );
                            }),
                      ),
                    ],
                  );
                }
              ),
            ),
          );
        }
    );
  }
}