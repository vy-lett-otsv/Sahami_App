import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/viewmodel/main_view_model.dart';
import 'package:sahami_app/viewmodel/product_view_model.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_add_image.dart';
import 'package:sahami_app/views/widget/ui_button_primary.dart';
import 'package:sahami_app/views/widget/ui_label.dart';
import 'package:sahami_app/views/widget/ui_label_text_input.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import '../../../../data/remote/entity/product_entity.dart';
import '../../../../viewmodel/category_view_model.dart';
import '../../../widget/bottomsheet_model.dart';
import '../../../widget/ui_button_small.dart';
import '../../home/main_view.dart';

class ProductCreateView extends StatefulWidget {
  const ProductCreateView({Key? key}) : super(key: key);

  @override
  State<ProductCreateView> createState() => _ProductCreateViewState();
}

class _ProductCreateViewState extends State<ProductCreateView> {
  final ProductViewModel _productViewModel = ProductViewModel();
  final CategoryViewModel _categoryViewModel = CategoryViewModel();
  final MainViewModel _mainViewModel = MainViewModel();

  @override
  void initState() {
    _productViewModel.categoryController = TextEditingController();
    _categoryViewModel.getAllCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _productViewModel),
        ChangeNotifierProvider(create: (_) => _categoryViewModel),
        ChangeNotifierProvider(create: (_) => _mainViewModel),
      ],
      child: Scaffold(
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
        body: Consumer<ProductViewModel>(
          builder: (_, product, __) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: DimensManager.dimens.setWidth(20),
                    vertical: DimensManager.dimens.setHeight(10)),
                child: Column(
                  children: [
                    _buildAddImage(product),
                    SizedBox(height: DimensManager.dimens.setHeight(10)),
                    _buildBasicInf(),
                    SizedBox(height: DimensManager.dimens.setHeight(10)),
                    Consumer<CategoryViewModel>(builder: (_, category, __) {
                      return _buildCategory(
                          controller: _productViewModel.categoryController,
                          categoryViewModel: category);
                    }),
                    SizedBox(height: DimensManager.dimens.setHeight(10)),
                    _buildInfNutri(),
                    SizedBox(height: DimensManager.dimens.setHeight(20)),
                    Consumer<MainViewModel>(builder: (_, mainViewModel, __) {
                      return UIButtonPrimary(
                        text: UIStrings.createProduct,
                        onPress: () {
                          product.addProduct(context);
                        },
                      );
                    }),
                    SizedBox(height: DimensManager.dimens.setHeight(20)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAddImage(ProductViewModel productViewModel) {
    return productViewModel.selectedFileName.isEmpty
        ? UIAddImage(onTap: () {
            _buildAddImageBottomSheet(productViewModel);
          })
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(File(productViewModel.file!.path),
                    width: DimensManager.dimens.setWidth(100),
                    height: DimensManager.dimens.setHeight(100),
                    fit: BoxFit.cover),
              ),
              SizedBox(
                width: DimensManager.dimens.setWidth(20),
              ),
              Row(
                children: [
                  UIButtonSmall(
                    text: UIStrings.edit,
                    onPress: () {
                      _buildAddImageBottomSheet(productViewModel);
                    },
                  ),
                  SizedBox(
                    width: DimensManager.dimens.setWidth(10),
                  ),
                  UIButtonSmall(
                    text: UIStrings.delete,
                    onPress: () {},
                  ),
                ],
              )
            ],
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
            controller: _productViewModel.controllerName,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          UILabelTextInput(
            title: UIStrings.price,
            unit: UIStrings.vnd,
            inputNumber: true,
            controller: _productViewModel.controllerPrice,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          UILabelTextInput(
            title: UIStrings.des,
            controller: _productViewModel.controllerDes,
            // focusNode: myFocusNode,
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(
      {required TextEditingController controller,
      required CategoryViewModel categoryViewModel}) {
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
          UIText(controller.text.isEmpty ? UIStrings.notYet : controller.text),
          GestureDetector(
            child: Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 24,
              color: UIColors.text,
            ),
            onTap: () async {
              final result = await BottomSheetDialog.showCategoryDialog(
                context: context,
                categories: categoryViewModel.categories,
                selectedIndex: categoryViewModel.selectedCategory,
              );
              if (result != null) {
                final itemCategory = categoryViewModel.categories[result];
                setState(() {
                  _productViewModel.categoryController.text =
                      itemCategory.categoryName;
                  _productViewModel.categoryName = itemCategory.categoryName;
                });
              }
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
            controller: _productViewModel.controllerServingSize,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          UILabelTextInput(
            title: UIStrings.saturatedFat,
            notNull: false,
            unit: UIStrings.inG,
            inputNumber: true,
            controller: _productViewModel.controllerSaturatedFat,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          UILabelTextInput(
            title: UIStrings.protein,
            notNull: false,
            unit: UIStrings.inG,
            inputNumber: true,
            controller: _productViewModel.controllerProtein,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          UILabelTextInput(
            title: UIStrings.sodium,
            notNull: false,
            unit: UIStrings.inMg,
            inputNumber: true,
            controller: _productViewModel.controllerSodium,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          UILabelTextInput(
            title: UIStrings.sugars,
            notNull: false,
            unit: UIStrings.inG,
            inputNumber: true,
            controller: _productViewModel.controllerSugar,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          UILabelTextInput(
            title: UIStrings.caffeine,
            notNull: false,
            unit: UIStrings.inMg,
            inputNumber: true,
            controller: _productViewModel.controllerCaffeine,
          ),
        ],
      ),
    );
  }

  void _buildAddImageBottomSheet(ProductViewModel productViewModel) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const UIText("Camera"),
                onTap: () {
                  productViewModel.selectFile(false);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const UIText("Gallery"),
                onTap: () {
                  productViewModel.selectFile(true);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
