import 'dart:io';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/views/assets/asset_icons.dart';
import 'package:sahami_app/views/widget/ui_button_primary.dart';
import 'package:sahami_app/views/widget/ui_button_small.dart';
import 'package:sahami_app/views/widget/ui_label.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import '../../../viewmodel/managers/create_category_view_model.dart';
import '../../../viewmodel/managers/create_product_view_model.dart';
import '../../constants/dimens_manager.dart';
import '../../constants/ui_color.dart';
import '../../constants/ui_strings.dart';
import '../../widget/ui_label_text_input.dart';
import '../../widget/ui_title.dart';

class ManageCreateProductView extends StatefulWidget {
  const ManageCreateProductView({Key? key}) : super(key: key);

  @override
  State<ManageCreateProductView> createState() =>
      _ManageCreateProductViewState();
}

class _ManageCreateProductViewState extends State<ManageCreateProductView> {
  final CreateCategoryViewModel _categoryViewModel = CreateCategoryViewModel();
  final CreateProductViewModel _productViewModel = CreateProductViewModel();
  // var _selected = 0;
  // String selectedFileName = '';
  // XFile? file;
  //
  // _selectFile(bool imageFrom) async {
  //   file = await ImagePicker().pickImage(
  //       source: imageFrom ? ImageSource.gallery : ImageSource.camera);
  //   if (file != null) {
  //     setState(() {
  //       selectedFileName = file!.name;
  //     });
  //   }
  //   print(file!.name);
  // }

  @override
  void initState() {
    super.initState();
    DimensManager();
    _categoryViewModel.getAllCategory();
    _productViewModel.updateUI();
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
            title: const Center(
                child: UITilte(UIStrings.addNewProduct, color: UIColors.white)),
            backgroundColor: UIColors.primary,
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
                          return _buildCategory(category, product);
                        },
                      ),
                      SizedBox(height: DimensManager.dimens.setHeight(10)),
                      _buildInfNutri(),
                      SizedBox(height: DimensManager.dimens.setHeight(20)),
                      const UIButtonPrimary(text: "Create Product"),
                      SizedBox(height: DimensManager.dimens.setHeight(20)),
                    ],
                  );
                },
              ),
            ),
          )),
    );
  }

  Widget _buildAddImage(CreateProductViewModel product) {
    return GestureDetector(
      onTap: () {
        _buildAddImageBottomSheet(product);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: DimensManager.dimens.setWidth(20),
            vertical: DimensManager.dimens.setHeight(10)),
        child: product.selectedFileName.isEmpty
            ? Container(
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(File(product.file!.path),
                        width: DimensManager.dimens.setWidth(100),
                        height: DimensManager.dimens.setHeight(100),
                        fit: BoxFit.cover),
                  ),
                  const UIButtonSmall(text: UIStrings.edit),
                  const UIButtonSmall(text: UIStrings.delete),
                ],
              ),
      ),
    );
  }

  void _buildAddImageBottomSheet(CreateProductViewModel product) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const UIText("Camera"),
                onTap: () {
                  product.selectFile(false);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const UIText("Gallery"),
                onTap: () {
                  product.selectFile(true);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
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
          const UILabelTextInput(
            title: UIStrings.name,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          const UILabelTextInput(
            title: UIStrings.price,
            unit: UIStrings.vnd,
            inputNumber: true,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          const UILabelTextInput(
            title: UIStrings.des,
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(CreateCategoryViewModel category, CreateProductViewModel product) {
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
          const UIText(UIStrings.notYet),
          GestureDetector(
            child: Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 24,
              color: UIColors.text,
            ),
            onTap: () {
              _buildCategoryBottomSheet(category, product);
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
          const UILabelTextInput(
            title: UIStrings.servingSize,
            notNull: false,
            unit: UIStrings.inKcal,
            inputNumber: true,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          const UILabelTextInput(
            title: UIStrings.saturatedFat,
            notNull: false,
            unit: UIStrings.inG,
            inputNumber: true,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          const UILabelTextInput(
            title: UIStrings.protein,
            notNull: false,
            unit: UIStrings.inG,
            inputNumber: true,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          const UILabelTextInput(
            title: UIStrings.sodium,
            notNull: false,
            unit: UIStrings.inMg,
            inputNumber: true,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          const UILabelTextInput(
            title: UIStrings.sugars,
            notNull: false,
            unit: UIStrings.inG,
            inputNumber: true,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          const UILabelTextInput(
            title: UIStrings.caffeine,
            notNull: false,
            unit: UIStrings.inMg,
            inputNumber: true,
          ),
        ],
      ),
    );
  }

  Future<void> _buildCategoryBottomSheet(CreateCategoryViewModel category, CreateProductViewModel product) {
    // var valueProvider = Provider.of<CreateCategoryViewModel>(context, listen: false);
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(DimensManager.dimens.setRadius(20)))),
        context: context,
        builder: (context) {
          return Column(
            children: [
              _buildHeaderBottomSheet(),
              Expanded(child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return ListView.builder(
                    itemCount: category.categories.length,
                    itemBuilder: (context, index) {
                      final itemCategory = category.categories[index];
                      return RadioListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        groupValue: product.selected,
                        title: Text(itemCategory.name),
                        onChanged: (value) {
                          // setState(() {
                          //   product.selected = value;
                          //   print("Hi ${itemCategory.id}");
                          // });
                          product.setSelectedCategory(value);
                        },
                        value: index,
                      );
                    });
              }))
            ],
          );
        });
  }

  Widget _buildHeaderBottomSheet() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: DimensManager.dimens.setHeight(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context, '');
                },
                icon: const Icon(Icons.keyboard_arrow_left_rounded, size: 24),
              ),
              const UITilte(UIStrings.category),
              const SizedBox(width: 44),
            ],
          ),
        ),
        Divider(color: UIColors.text),
      ],
    );
  }
}
