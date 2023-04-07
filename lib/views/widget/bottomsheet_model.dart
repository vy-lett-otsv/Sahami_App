import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/data/remote/entity/category_entity.dart';
import 'package:sahami_app/viewmodel/managers/create_category_view_model.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/widget/ui_title.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/ui_color.dart';
import '../constants/ui_strings.dart';

class BottomSheetDialog {
  static ShapeBorder shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
    topLeft: Radius.circular(DimensManager.dimens.setWidth(20)),
    topRight: Radius.circular(DimensManager.dimens.setWidth(20)),
  ));

  static Future<int?> showCategoryDialog({
    required BuildContext context,
    required List<CategoryEntity> categories,
    required int selectedIndex,
  }) {
    return showModalBottomSheet(
        shape: shape,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, innerSetState) {
            return FractionallySizedBox(
                heightFactor: 0.8,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: DimensManager.dimens.setHeight(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.keyboard_arrow_left_rounded,
                                size: 24),
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
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final itemCategory = categories[index];
                            return RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              groupValue: selectedIndex,
                              title: Text(itemCategory.categoryName),
                              onChanged: (value) {
                                selectedIndex = value!;
                                innerSetState(() {});
                                Future.delayed(const Duration(milliseconds: 1000), () {
                                  Navigator.of(context).pop(value);
                                });
                              },
                              value: index,
                            );
                          }),
                    ),
                  ],
                ));
          });
        });
  }
}
