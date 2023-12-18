import 'package:flutter/material.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/widget/ui_icon_button.dart';

import '../../../assets/asset_images.dart';
import '../../../constants/ui_color.dart';
import '../../../widget/ui_text.dart';
import '../../../widget/ui_title.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({Key? key}) : super(key: key);

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: DimensManager.dimens.fullWidth,
              // height: DimensManager.dimens.productImageSize,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AssetImages.product1),
                      fit: BoxFit.cover)),
            ),
          ),
          Positioned(
            top: DimensManager.dimens.setHeight(50),
            left: DimensManager.dimens.setWidth(20),
            right: DimensManager.dimens.setWidth(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                UIIconButton(icon: Icons.arrow_back_ios),
                UIIconButton(icon: Icons.shopping_cart_outlined)
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            // top: DimensManager.dimens.productImageSize - 50,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: DimensManager.dimens.setWidth(20),
                vertical: DimensManager.dimens.setHeight(10)
              ),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(
                        topRight: Radius.circular(DimensManager.dimens.setRadius(20)),
                        topLeft: Radius.circular(DimensManager.dimens.setRadius(20)),
                      ),
                  color: UIColors.background),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UITitle("Món gì đây"),
                  SizedBox(height: DimensManager.dimens.setHeight(10)),
                  Row(
                    children: [
                      Wrap(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            color: UIColors.star,
                            size: 15,
                          );
                        }),
                      ),
                      SizedBox(width: DimensManager.dimens.setWidth(20)),
                      const UIText("5.0"),
                      SizedBox(width: DimensManager.dimens.setWidth(20)),
                      const UIText("38 Comment"),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
