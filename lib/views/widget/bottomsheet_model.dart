import 'package:flutter/material.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import 'package:sahami_app/views/widget/ui_title.dart';
import '../../data/remote/enitity/category_entity.dart';
import '../constants/ui_color.dart';
import '../constants/ui_strings.dart';

class BottomSheetDialog {
  static ShapeBorder shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(DimensManager.dimens.setWidth(20)),
        topRight: Radius.circular(DimensManager.dimens.setWidth(20)),
      ));

  static showCustomerDialog({
    required BuildContext context,
  }) {
    return showModalBottomSheet(
        shape: shape,
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: DimensManager.dimens.setHeight(0.5),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: DimensManager.dimens.setWidth(20)
                  ),
                  child: Center(child: UITilte(UIStrings.filter, color: UIColors.primary)),
                ),
                Divider(color: UIColors.text),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: DimensManager.dimens.setWidth(20)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const UIText(UIStrings.city),
                          IconButton(
                            onPressed: () {

                            },
                            icon: Icon(Icons.keyboard_arrow_right_rounded, size: 24, color: UIColors.text),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const UIText(UIStrings.label),
                          IconButton(
                            onPressed: () {

                            },
                            icon: Icon(Icons.keyboard_arrow_right_rounded, size: 24, color: UIColors.text),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

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
                heightFactor: DimensManager.dimens.setHeight(0.8),
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
                          SizedBox(width: DimensManager.dimens.setWidth(44)),
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