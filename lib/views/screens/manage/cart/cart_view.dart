import 'package:flutter/material.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_button_primary.dart';
import 'package:sahami_app/views/widget/ui_icon_button.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import '../../../constants/ui_color.dart';
import '../../../widget/ui_title.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: DimensManager.dimens.setWidth(20),
            vertical: DimensManager.dimens.setHeight(10),
          ),
          color: UIColors.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const UIIconButton(
                    icon: Icons.arrow_back_ios,
                  ),
                  UITitle(
                    UIStrings.cart,
                    fontWeight: FontWeight.bold,
                    color: UIColors.primary,
                  ),
                  const UIIconButton(
                    icon: Icons.home,
                  )
                ],
              ),
              SizedBox(
                height: DimensManager.dimens.setHeight(20),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      height: DimensManager.dimens.setHeight(100),
                      margin: EdgeInsets.only(bottom: DimensManager.dimens.setHeight(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                DimensManager.dimens.setRadius(10)),
                            child: Image.network(
                              "https://i.pinimg.com/564x/72/42/81/7242814acfff93a8588e36a2837e95f2.jpg",
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: DimensManager.dimens.setWidth(10),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Flexible(
                                flex: 1,
                                child: UIText(
                                  "Blonde Vanilla Latte",
                                  fontWeight: FontWeight.bold,
                                  size: DimensManager.dimens.setSp(18),
                                )),
                            Flexible(
                                flex: 1,
                                child: UIText(
                                  "Hot Coffee",
                                  fontWeight: FontWeight.w100,
                                  size: DimensManager.dimens.setSp(16),
                                )),
                            Flexible(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  UIText(
                                    "22,000 VNĐ",
                                    fontWeight: FontWeight.bold,
                                    size: DimensManager.dimens.setSp(18),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            DimensManager.dimens
                                                .setRadius(20)),
                                        color: UIColors.white),
                                    child: Row(
                                      children: [
                                        IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {},
                                            icon: const Icon(Icons.remove)),
                                        const UIText("1"),
                                        IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {},
                                            icon: const Icon(Icons.add)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: DimensManager.dimens.setHeight(10)
                ),
                child: UIButtonPrimary(
                  text: UIStrings.paymentOption,
                  paddingHorizontal: DimensManager.dimens.setWidth(20),
                  radius: DimensManager.dimens.setRadius(20),
                  light: true,
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: DimensManager.dimens.setHeight(100),
        decoration: BoxDecoration(
          color: UIColors.backgroundBottom,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(DimensManager.dimens.setRadius(30)),
            topRight: Radius.circular(DimensManager.dimens.setRadius(30)),
          ),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: DimensManager.dimens.setWidth(20)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(10)),
                  color: UIColors.white),
              padding: EdgeInsets.symmetric(
                  vertical: DimensManager.dimens.setHeight(15),
                  horizontal: DimensManager.dimens.setWidth(5)
              ),
              child: const UIText("106,000 VNĐ"),
            ),
            UIButtonPrimary(
                text: UIStrings.checkout,
                paddingHorizontal: DimensManager.dimens.setWidth(20),
                radius: DimensManager.dimens.setRadius(10),
                light: true,
            )
          ],
        ),
      ),
    );
  }
}
