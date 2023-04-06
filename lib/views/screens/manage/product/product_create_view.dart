import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/data/remote/entity/product_entity.dart';
import 'package:sahami_app/views/assets/asset_icons.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_button_primary.dart';
import 'package:sahami_app/views/widget/ui_button_small.dart';
import 'package:sahami_app/views/widget/ui_label.dart';
import 'package:sahami_app/views/widget/ui_label_text_input.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import 'package:sahami_app/views/widget/ui_title.dart';
import '../../../../services/navigation_service.dart';
import '../../../../viewmodel/managers/create_category_view_model.dart';
import '../../../../viewmodel/managers/create_product_view_model.dart';
import '../../../widget/bottomsheet_model.dart';

class ProductCreateView extends StatefulWidget {
  const ProductCreateView({Key? key}) : super(key: key);

  @override
  State<ProductCreateView> createState() =>
      _ProductCreateViewState();
}

class _ProductCreateViewState extends State<ProductCreateView> {
  final CreateCategoryViewModel _categoryViewModel = CreateCategoryViewModel();
  final CreateProductViewModel _productViewModel = CreateProductViewModel();
  final _controllerName = TextEditingController();
  final _controllerPrice = TextEditingController();
  final _controllerDes = TextEditingController();
  final _controllerServingSize = TextEditingController();
  final _controllerSaturatedFat = TextEditingController();
  final _controllerProtein = TextEditingController();
  final _controllerSodium = TextEditingController();
  final _controllerSugar = TextEditingController();
  final _controllerCaffeine = TextEditingController();
  late TextEditingController _categoryController;
  String categoryId = " ";
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    DimensManager();
    _categoryController = TextEditingController();
    _categoryViewModel.getAllCategory();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _categoryViewModel),
        ChangeNotifierProvider(create: (_) => _productViewModel),
      ],
      child: Scaffold(
          appBar: AppBar(
            title: const UITilte(UIStrings.addNewProduct, color: UIColors.white),
            backgroundColor: UIColors.primary,
            leading: GestureDetector(
                child: const Icon(Icons.arrow_back),
              onTap: () {
                NavigationServices.instance.navigationToProductHomeScreen(context);
              },
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: DimensManager.dimens.setWidth(20),
                  vertical: DimensManager.dimens.setHeight(10)),
              child: Consumer<CreateProductViewModel>(
                builder: (_, product, __) {
                  return Column(
                    children: [
                      _buildAddImage(product),
                      SizedBox(height: DimensManager.dimens.setHeight(10)),
                      _buildBasicInf(),
                      SizedBox(height: DimensManager.dimens.setHeight(10)),
                      Consumer<CreateCategoryViewModel>(
                        builder: (_, category, __) {
                          return _buildCategory(
                            controller: _categoryController,
                            categoryViewModel: category
                          );
                        },
                      ),
                      SizedBox(height: DimensManager.dimens.setHeight(10)),
                      _buildInfNutri(),
                      SizedBox(height: DimensManager.dimens.setHeight(20)),
                      Consumer<CreateCategoryViewModel>(
                        builder: (_, category, __) {
                          return UIButtonPrimary(
                              text: "Create Product",
                              onPress: () {
                                final productEntity = ProductEntity(
                                  productName: _controllerName.text,
                                  description: _controllerDes.text,
                                  price: double.parse(_controllerPrice.text),
                                  categoryId: categoryId,
                                  servingSize: double.parse(_controllerServingSize.text),
                                  saturatedFat: double.parse(_controllerSaturatedFat.text),
                                  protein: double.parse(_controllerProtein.text),
                                  sodium: double.parse(_controllerSodium.text),
                                  sugars: double.parse(_controllerSugar.text),
                                  caffeine: double.parse(_controllerCaffeine.text),
                                );
                                _productViewModel.createProduct(productEntity, categoryId);
                                // _productViewModel.setTest();
                              });
                        },
                      ),
                      SizedBox(height: DimensManager.dimens.setHeight(20)),
                    ],
                  );
                },
                // child:
              ),
            ),
          )),
    );
  }

  Widget _buildAddImage(CreateProductViewModel productViewModel) {
    return GestureDetector(
      onTap: () {
        _buildAddImageBottomSheet(productViewModel);
      },
      child: productViewModel.selectedFileName.isEmpty
          ? Container(
              padding: EdgeInsets.symmetric(
                  horizontal: DimensManager.dimens.setWidth(20),
                  vertical: DimensManager.dimens.setHeight(10)),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(DimensManager.dimens.setRadius(10)),
                color: UIColors.white,
              ),
              child: Row(
                children: [
                  Image.asset(AssetIcons.iconAddImage,
                      width: DimensManager.dimens.setWidth(50)),
                  SizedBox(
                    width: DimensManager.dimens.setWidth(10),
                  ),
                  const UIText(UIStrings.addNewImage)
                ],
              ),
            )
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
                    const UIButtonSmall(text: UIStrings.delete),
                  ],
                )
              ],
            ),
    );
  }

  Widget _buildBasicInf() {
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
            title: UIStrings.name,
            controller: _controllerName,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          UILabelTextInput(
            title: UIStrings.price,
            unit: UIStrings.vnd,
            inputNumber: true,
            controller: _controllerPrice,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          UILabelTextInput(
            title: UIStrings.des,
            controller: _controllerDes,
            // focusNode: myFocusNode,
          ),
        ],
      ),
    );
  }

  Widget _buildCategory({required TextEditingController controller, required CreateCategoryViewModel categoryViewModel}) {
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
              controller.text.isEmpty
                  ? UIStrings.notYet
                  :controller.text
          ),
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
              if(result!=null) {
                final itemCategory = categoryViewModel.categories[result];
                setState(() {
                  _categoryController.text = itemCategory.categoryName;
                  categoryId = itemCategory.categoryId;
                });
              };
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
            controller: _controllerServingSize,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          UILabelTextInput(
            title: UIStrings.saturatedFat,
            notNull: false,
            unit: UIStrings.inG,
            inputNumber: true,
            controller: _controllerSaturatedFat,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          UILabelTextInput(
            title: UIStrings.protein,
            notNull: false,
            unit: UIStrings.inG,
            inputNumber: true,
            controller: _controllerProtein,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          UILabelTextInput(
            title: UIStrings.sodium,
            notNull: false,
            unit: UIStrings.inMg,
            inputNumber: true,
            controller: _controllerSodium,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          UILabelTextInput(
            title: UIStrings.sugars,
            notNull: false,
            unit: UIStrings.inG,
            inputNumber: true,
            controller: _controllerSugar,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          UILabelTextInput(
            title: UIStrings.caffeine,
            notNull: false,
            unit: UIStrings.inMg,
            inputNumber: true,
            controller: _controllerCaffeine,
          ),
        ],
      ),
    );
  }

  void _buildAddImageBottomSheet(CreateProductViewModel productViewModel) {
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
