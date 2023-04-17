import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_add_image.dart';
import 'package:sahami_app/views/widget/ui_button_primary.dart';
import 'package:sahami_app/views/widget/ui_label.dart';
import 'package:sahami_app/views/widget/ui_label_text_input.dart';
import 'package:sahami_app/views/widget/ui_text.dart';

class ProductCreateView extends StatefulWidget {
  const ProductCreateView({Key? key}) : super(key: key);

  @override
  State<ProductCreateView> createState() =>
      _ProductCreateViewState();
}

class _ProductCreateViewState extends State<ProductCreateView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(UIStrings.addNewProduct),
          backgroundColor: UIColors.primary,
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: DimensManager.dimens.setWidth(20),
                vertical: DimensManager.dimens.setHeight(10)),
            child: Column(
              children: [
                _buildAddImage(),
                SizedBox(height: DimensManager.dimens.setHeight(10)),
                _buildBasicInf(),
                SizedBox(height: DimensManager.dimens.setHeight(10)),
                _buildCategory(),
                SizedBox(height: DimensManager.dimens.setHeight(10)),
                _buildInfNutri(),
                SizedBox(height: DimensManager.dimens.setHeight(20)),
                UIButtonPrimary(
                    text: UIStrings.createProduct,
                    onPress: () {
                      // final productEntity = ProductEntity(
                      //   productName: _controllerName.text,
                      //   description: _controllerDes.text,
                      //   price: double.parse(_controllerPrice.text),
                      //   categoryId: categoryId,
                      //   servingSize: double.parse(_controllerServingSize.text),
                      //   saturatedFat: double.parse(_controllerSaturatedFat.text),
                      //   protein: double.parse(_controllerProtein.text),
                      //   sodium: double.parse(_controllerSodium.text),
                      //   sugars: double.parse(_controllerSugar.text),
                      //   caffeine: double.parse(_controllerCaffeine.text),
                      // );
                      // _productViewModel.createProduct(productEntity, categoryId);
                      // _productViewModel.setTest();
                    }),
                SizedBox(height: DimensManager.dimens.setHeight(20)),
              ],
            ),
          ),
        ));
  }

  Widget _buildAddImage() {
    return GestureDetector(
      onTap: () {
        _buildAddImageBottomSheet();
      },
      child: UIAddImage(onTap: () {  })
      //     : Row(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     ClipRRect(
      //       borderRadius: BorderRadius.circular(10),
      //       child: Image.file(File(productViewModel.file!.path),
      //           width: DimensManager.dimens.setWidth(100),
      //           height: DimensManager.dimens.setHeight(100),
      //           fit: BoxFit.cover),
      //     ),
      //     SizedBox(
      //       width: DimensManager.dimens.setWidth(20),
      //     ),
      //     Row(
      //       children: [
      //         UIButtonSmall(
      //           text: UIStrings.edit,
      //           onPress: () {
      //             _buildAddImageBottomSheet(productViewModel);
      //           },
      //         ),
      //         SizedBox(
      //           width: DimensManager.dimens.setWidth(10),
      //         ),
      //         const UIButtonSmall(text: UIStrings.delete),
      //       ],
      //     )
      //   ],
      // ),
    );
  }

  Widget _buildBasicInf() {
    return Container(
      padding: EdgeInsets.all(DimensManager.dimens.setWidth(30)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(10)),
        color: UIColors.white,
      ),
      child: Column(
        children: [
          UILabelTextInput(
            title: UIStrings.name,
            // controller: _controllerName,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          UILabelTextInput(
            title: UIStrings.price,
            unit: UIStrings.vnd,
            inputNumber: true,
            // controller: _controllerPrice,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          UILabelTextInput(
            title: UIStrings.des,
            // controller: _controllerDes,
            // focusNode: myFocusNode,
          ),
        ],
      ),
    );
  }

  Widget _buildCategory() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: DimensManager.dimens.setWidth(20),
          vertical: DimensManager.dimens.setHeight(20)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(10)),
        color: UIColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const UILabel(title: UIStrings.category),
          const Spacer(),
          UIText(
              UIStrings.notYet
              // controller.text.isEmpty
              //     ? UIStrings.notYet
              //     :controller.text
          ),
          GestureDetector(
            child: Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 24,
              color: UIColors.text,
            ),
            onTap: () async {
              // final result = await BottomSheetDialog.showCategoryDialog(
              //   context: context,
              //   categories: categoryViewModel.categories,
              //   selectedIndex: categoryViewModel.selectedCategory,
              // );
              // if(result!=null) {
              //   final itemCategory = categoryViewModel.categories[result];
              //   setState(() {
              //     _categoryController.text = itemCategory.categoryName;
              //     categoryId = itemCategory.categoryId;
              //   });
              // };
            },
          )
        ],
      ),
    );
  }

  Widget _buildInfNutri() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: DimensManager.dimens.setWidth(20),
          vertical: DimensManager.dimens.setHeight(50)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(10)),
        color: UIColors.white,
      ),
      child: Column(
        children: [
          UILabelTextInput(
            title: UIStrings.servingSize,
            notNull: false,
            unit: UIStrings.inKcal,
            inputNumber: true,
            // controller: _controllerServingSize,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          UILabelTextInput(
            title: UIStrings.saturatedFat,
            notNull: false,
            unit: UIStrings.inG,
            inputNumber: true,
            // controller: _controllerSaturatedFat,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          UILabelTextInput(
            title: UIStrings.protein,
            notNull: false,
            unit: UIStrings.inG,
            inputNumber: true,
            // controller: _controllerProtein,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          UILabelTextInput(
            title: UIStrings.sodium,
            notNull: false,
            unit: UIStrings.inMg,
            inputNumber: true,
            // controller: _controllerSodium,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          UILabelTextInput(
            title: UIStrings.sugars,
            notNull: false,
            unit: UIStrings.inG,
            inputNumber: true,
            // controller: _controllerSugar,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          UILabelTextInput(
            title: UIStrings.caffeine,
            notNull: false,
            unit: UIStrings.inMg,
            inputNumber: true,
            // controller: _controllerCaffeine,
          ),
        ],
      ),
    );
  }

  void _buildAddImageBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const UIText("Camera"),
                onTap: () {
                  // productViewModel.selectFile(false);
                  // Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const UIText("Gallery"),
                onTap: () {
                  // productViewModel.selectFile(true);
                  // Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}