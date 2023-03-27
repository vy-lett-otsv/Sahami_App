import 'package:flutter/material.dart';
import 'package:sahami_app/views/assets/asset_icons.dart';
import 'package:sahami_app/views/widget/ui_text.dart';

import '../../constants/dimens_manager.dart';
import '../../constants/ui_color.dart';
import '../../constants/ui_strings.dart';
import '../../widget/ui_title.dart';

class ManageCreateProductView extends StatefulWidget {
  const ManageCreateProductView({Key? key}) : super(key: key);

  @override
  State<ManageCreateProductView> createState() =>
      _ManageCreateProductViewState();
}

class _ManageCreateProductViewState extends State<ManageCreateProductView> {
  @override
  void initState() {
    super.initState();
    DimensManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: UITilte(UIStrings.addNewProduct, color: UIColors.white)),
          backgroundColor: UIColors.primary,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: DimensManager.dimens.setWidth(20)
            ),
            child: Column(
              children: [
                SizedBox(height: DimensManager.dimens.setHeight(10)),
                Container(
                  color: UIColors.white,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: (){} ,
                          icon: Image.asset(AssetIcons.iconAddImage,),
                      ),
                      UIText(UIStrings.addNewImage)
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
