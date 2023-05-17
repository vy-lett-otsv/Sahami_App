import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/services/cart_service.dart';
import 'package:sahami_app/viewmodel/cart_view_model.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_button_primary.dart';
import 'package:sahami_app/views/widget/ui_icon_button.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import '../../../constants/ui_color.dart';
import '../../../widget/ui_title.dart';
import 'package:intl/intl.dart' as intl;


class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final CartViewModel _cartViewModel = CartViewModel();
  @override
  Widget build(BuildContext context) {
    final formatter = intl.NumberFormat.decimalPattern();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => _cartViewModel)
        ],
      child: Consumer<CartViewModel>(
        builder: (_, viewModel, __) {
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
                        UIIconButton(
                          icon: Icons.arrow_back_ios_new,
                          onPressed: () {
                            Navigator.pop(context);
                          },
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
                      child: ListView.separated(
                        itemCount: CartService().orderList.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          viewModel.displayTextOptionItem(index);
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: DimensManager.dimens.setHeight(10)),
                            constraints: BoxConstraints(minHeight: DimensManager.dimens.setHeight(100),),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      DimensManager.dimens.setRadius(10)),
                                  child: Image.network(
                                    CartService().orderList[index]['image'],
                                    width: DimensManager.dimens.setWidth(100),
                                    height: DimensManager.dimens.setHeight(100),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: DimensManager.dimens.setWidth(10),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      UIText(
                                        CartService().orderList[index]['name_product'],
                                        fontWeight: FontWeight.bold,
                                        size: DimensManager.dimens.setSp(18),
                                      ),
                                      SizedBox(height: DimensManager.dimens.setHeight(10),),
                                      UIText(
                                        viewModel.getNamedSyrup().values.join('\n'),
                                        fontWeight: FontWeight.w100,
                                        size: DimensManager.dimens.setSp(16),
                                      ),
                                      SizedBox(height: DimensManager.dimens.setHeight(10),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          UIText(
                                            CartService().orderList[index]['priceSale'] != null ? "${formatter.format(CartService().orderList[index]['priceSale'])} VNĐ" : "${formatter.format(CartService().orderList[index]['price'])} VNĐ",
                                            fontWeight: FontWeight.bold,
                                            size: DimensManager.dimens.setSp(18),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(20)),
                                                color: UIColors.white),
                                            height: DimensManager.dimens.setHeight(40),
                                            child: Row(
                                              children: [
                                                IconButton(
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {

                                                    },
                                                    icon: const Icon(Icons.remove)),
                                                UIText("${CartService().orderList[index]['quantity']}"),
                                                IconButton(
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {},
                                                    icon: const Icon(Icons.add)),
                                              ],
                                            ),
                                          ),
                                        ],
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
                        backgroundColor: UIColors.primarySecond,
                        onPress: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return FractionallySizedBox(
                                    heightFactor: DimensManager.dimens.setHeight(1.5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(DimensManager.dimens.setRadius(20)),
                                            topRight: Radius.circular(DimensManager.dimens.setRadius(20))
                                        ),
                                        color: Colors.teal,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: DimensManager.dimens.setWidth(20)
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            color: Colors.orange,
                                            height: DimensManager.dimens.setHeight(50),
                                            child: Row(

                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                );
                              }
                          );
                        },
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
                    backgroundColor: UIColors.primarySecond,
                    onPress: () {
                      // viewModel.test();
                    },
                  )
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
