import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/views/assets/asset_icons.dart';
import 'package:sahami_app/views/widget/ui_label.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import '../../../data/remote/entity/category_entity.dart';
import '../../../viewmodel/managers/create_category_view_model.dart';
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
  late CategoryEntity selectCategory;

  @override
  void initState() {
    super.initState();
    DimensManager();
    _categoryViewModel.getAllCategory();
    selectCategory = CategoryEntity(name: ' ');
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _categoryViewModel),
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
              child: Column(
                children: [
                  _buildAddImage(),
                  SizedBox(height: DimensManager.dimens.setHeight(10)),
                  _buildBasicInf(),
                  SizedBox(height: DimensManager.dimens.setHeight(10)),
                  Consumer<CreateCategoryViewModel>(
                    builder: (_, category, __) {
                      return _buildCategory(category);
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildAddImage() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: DimensManager.dimens.setWidth(20),
          vertical: DimensManager.dimens.setHeight(10)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(10)),
        color: UIColors.white,
      ),
      child: Row(
        children: [
          Image.asset(AssetIcons.iconAddImage,
              width: DimensManager.dimens.setWidth(50)),
          SizedBox(
            width: DimensManager.dimens.setWidth(10),
          ),
          UIText(UIStrings.addNewImage)
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
          const UILabelTextInput(
            title: UIStrings.name,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          const UILabelTextInput(
            title: UIStrings.price,
            unit: UIStrings.vnd,
          ),
          SizedBox(height: DimensManager.dimens.setHeight(20)),
          const UILabelTextInput(
            title: UIStrings.des,
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(CreateCategoryViewModel category) {
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
          UIText(UIStrings.notYet),
          GestureDetector(
            child: Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 24,
              color: UIColors.text,
            ),
            onTap: () {
              _buildCategoryBottomSheet(category);
            },
          )
        ],
      ),
    );
  }

  Future<void> _buildCategoryBottomSheet(CreateCategoryViewModel category) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(DimensManager.dimens.setRadius(20)))),
        context: context,
        builder: (BuildContext context) {
          return Column(
            children: [
              _buildHeaderBottomSheet(),
              Expanded(
                 child:  ListView.builder(
                     itemCount: category.categories.length,
                     itemBuilder: (context, index) {
                       final itemCategory = category.categories[index];
                       return RadioListTile(
                         controlAffinity: ListTileControlAffinity.trailing,
                         groupValue: selectCategory.id,
                         title: Text(itemCategory.name),
                         onChanged: (currentCategory) {
                           setState(() {
                             selectCategory.id = currentCategory!;
                           });
                           category.getAllCategory();
                         },
                         value: itemCategory.id,
                       );
                     }
                 ),
              )
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