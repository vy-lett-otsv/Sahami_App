import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/services/auth_service.dart';
import 'package:sahami_app/services/cart_service.dart';
import 'package:sahami_app/viewmodel/cart_view_model.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_button_primary.dart';
import 'package:sahami_app/views/widget/ui_icon_button.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import 'package:intl/intl.dart' as intl;
import '../../../../data/data_local.dart';
import '../../../../enums/enum.dart';
import '../../../../services/navigation_service.dart';
import '../../../assets/asset_icons.dart';
import '../../../constants/ui_color.dart';
import '../../../widget/ui_title.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final CartViewModel _cartViewModel = CartViewModel();

  @override
  void initState() {
    _cartViewModel.calculate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = intl.NumberFormat.decimalPattern();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => _cartViewModel),
        ],
        child: Consumer<CartViewModel>(
          builder: (_, cartViewModel, __) {
            return Scaffold(
              body: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: DimensManager.dimens.setWidth(20),
                    vertical: DimensManager.dimens.setHeight(10),
                  ),
                  color: UIColors.background,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //header
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
                              UIStrings.payment,
                              fontWeight: FontWeight.bold,
                              color: UIColors.primary,
                            ),
                            UIIconButton(
                              icon: Icons.home,
                              onPressed: () {
                                NavigationServices().navigationToMainViewScreen(context, arguments: 0);
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: DimensManager.dimens.setHeight(30),
                        ),
                        //product
                        SizedBox(
                          height: DimensManager.dimens.setHeight(300),
                          child: CartService().orderList.isEmpty ?
                              const Align(
                                alignment: Alignment.topCenter,
                                  child: UIText(UIStrings.orderListEmpty)
                              )
                              : ListView.separated(
                            itemCount: CartService().orderList.length,
                            separatorBuilder: (context, index) =>
                            const Divider(),
                            itemBuilder: (context, index) {
                              cartViewModel.displayTextOptionItem(index);
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    vertical:
                                    DimensManager.dimens.setHeight(10)),
                                constraints: BoxConstraints(
                                  minHeight:
                                  DimensManager.dimens.setHeight(100),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          DimensManager.dimens.setRadius(10)),
                                      child: Image.network(
                                        CartService().orderList[index]['image'],
                                        width:
                                        DimensManager.dimens.setWidth(100),
                                        height:
                                        DimensManager.dimens.setHeight(100),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: DimensManager.dimens.setWidth(10),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          UIText(
                                            CartService().orderList[index]
                                            ['name_product'],
                                            fontWeight: FontWeight.bold,
                                            size:
                                            DimensManager.dimens.setSp(18),
                                          ),
                                          SizedBox(
                                            height: DimensManager.dimens
                                                .setHeight(10),
                                          ),
                                          UIText(
                                            cartViewModel
                                                .getNamedSyrup()
                                                .values
                                                .join('\n'),
                                            fontWeight: FontWeight.w100,
                                            size:
                                            DimensManager.dimens.setSp(16),
                                          ),
                                          SizedBox(
                                            height: DimensManager.dimens
                                                .setHeight(10),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              UIText(
                                                CartService().orderList[index]
                                                ['priceSale'] !=
                                                    null
                                                    ? "${formatter.format(CartService().orderList[index]['priceSale'])} VNĐ"
                                                    : "${formatter.format(CartService().orderList[index]['price'])} VNĐ",
                                                fontWeight: FontWeight.bold,
                                                size: DimensManager.dimens
                                                    .setSp(18),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        DimensManager.dimens
                                                            .setRadius(20)),
                                                    color: UIColors.white),
                                                height: DimensManager.dimens
                                                    .setHeight(40),
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                        padding:
                                                        EdgeInsets.zero,
                                                        onPressed: () {
                                                          cartViewModel
                                                              .quantityItem(
                                                              false, index);
                                                        },
                                                        icon: const Icon(
                                                            Icons.remove)),
                                                    UIText(
                                                        "${CartService().orderList[index]['quantity']}"),
                                                    IconButton(
                                                        padding:
                                                        EdgeInsets.zero,
                                                        onPressed: () {
                                                          cartViewModel
                                                              .quantityItem(
                                                              true, index);
                                                        },
                                                        icon: const Icon(
                                                            Icons.add)),
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
                        UITitle(
                          UIStrings.deliveryOption,
                          size: DimensManager.dimens.setSp(18),
                          color: UIColors.primary,
                        ),
                        Divider(
                          color: UIColors.primary,
                        ),
                        DataLocal.deliveryOption[0].isSelected == true ?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    cartViewModel.optionDelivery(0);
                                    cartViewModel.calculate();
                                    cartViewModel.isAddress = true;
                                  },
                                  child: _buildDelivery(0)
                                ),
                                SizedBox(height: DimensManager.dimens.setHeight(10),),
                                Container(
                                  padding: EdgeInsets.all(DimensManager.dimens.setHeight(10)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(10)),
                                    color: UIColors.white,
                                  ),
                                  child: TextField(
                                    controller: cartViewModel.addressController,
                                    decoration: InputDecoration.collapsed(
                                      hintText: AuthService().userEntity.address,
                                    ),
                                  )
                                ),
                                cartViewModel.isAddress ? Container()
                                    : Column(
                                    children: [
                                      SizedBox(height: DimensManager.dimens.setHeight(10),),
                                      UIText(UIStrings.inputAddress, color: UIColors.red, size: DimensManager.dimens.setSp(16),),
                                  ],
                                ),
                                SizedBox(height: DimensManager.dimens.setHeight(10),),
                                InkWell(
                                  onTap: () {
                                    cartViewModel.optionDelivery(1);
                                    cartViewModel.calculate();
                                    cartViewModel.isAddress = true;
                                  },
                                  child: _buildDelivery(1)
                                ),
                                SizedBox(height: DimensManager.dimens.setHeight(10),),
                              ],
                            )
                            : SizedBox(
                            height: DimensManager.dimens.setHeight(80),
                            child: ListView.builder(
                              itemCount: DataLocal.deliveryOption.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      cartViewModel.optionDelivery(index);
                                      cartViewModel.calculate();
                                      cartViewModel.isAddress = true;
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: DimensManager.dimens.setHeight(10)),
                                      child: _buildDelivery(index)
                                    ));
                              }),
                        ),

                        UITitle(
                          UIStrings.paymentOption,
                          size: DimensManager.dimens.setSp(18),
                          color: UIColors.primary,
                        ),
                        Divider(
                          color: UIColors.primary,
                        ),
                        _buildPayment(() {
                          cartViewModel.pickCash();
                        },
                            AssetIcons.iconCashNotPick,
                            AssetIcons.iconCashPick,
                            UIStrings.cash,
                            UIStrings.cashDes,
                            cartViewModel.isSelectedCash),
                        _buildPayment(() {
                          cartViewModel.pickDigital();
                        },
                            AssetIcons.iconDigitalNotPick,
                            AssetIcons.iconDigitalPick,
                            UIStrings.digital,
                            UIStrings.digitalDes,
                            cartViewModel.isSelectedDigital),
                        UITitle(
                          UIStrings.note,
                          size: DimensManager.dimens.setSp(18),
                          color: UIColors.primary,
                        ),
                        Divider(
                          color: UIColors.primary,
                        ),
                        Container(
                          height: DimensManager.dimens.setHeight(100),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                DimensManager.dimens.setRadius(20)),
                            color: UIColors.white,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: DimensManager.dimens.setWidth(20),
                              vertical: DimensManager.dimens.setHeight(10)),
                          child: TextField(
                            controller: cartViewModel.noteController,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 5,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration.collapsed(
                                hintText: UIStrings.hintNote,
                                hintStyle: TextStyle(
                                    fontSize: DimensManager.dimens.setSp(16))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                height: DimensManager.dimens.setHeight(100),
                decoration: BoxDecoration(
                  color: UIColors.backgroundBottom,
                  borderRadius: BorderRadius.only(
                    topLeft:
                        Radius.circular(DimensManager.dimens.setRadius(30)),
                    topRight:
                        Radius.circular(DimensManager.dimens.setRadius(30)),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: DimensManager.dimens.setWidth(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              DimensManager.dimens.setRadius(10)),
                          color: UIColors.white),
                      padding: EdgeInsets.symmetric(
                          vertical: DimensManager.dimens.setHeight(15),
                          horizontal: DimensManager.dimens.setWidth(5)),
                      child: UIText("${formatter.format(cartViewModel.total)} VNĐ"),
                    ),
                    UIButtonPrimary(
                      text: UIStrings.checkout,
                      paddingHorizontal: DimensManager.dimens.setWidth(20),
                      radius: DimensManager.dimens.setRadius(10),
                      backgroundColor: UIColors.primarySecond,
                      onPress: () {
                          cartViewModel.checkAddress(context);
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget _buildDelivery(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: DimensManager.dimens.setHeight(20),
              width: DimensManager.dimens.setWidth(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 2,
                      color: UIColors.primary)),
            ),
            DataLocal.deliveryOption[index].isSelected
                ? Container(
              height: DimensManager.dimens.setHeight(10),
              width: DimensManager.dimens.setWidth(10),
              decoration: BoxDecoration(color: UIColors.primary, shape: BoxShape.circle,
              ),
            )
                : Container(),
          ],
        ),
        SizedBox(width: DimensManager.dimens.setWidth(10),),
        UIText(DataLocal.deliveryOption[index].name),
        SizedBox(width: DimensManager.dimens.setWidth(3),),
        UITitle("(${DataLocal.deliveryOption[index].price})", size: DimensManager.dimens.setSp(18),
        )
      ],
    );
  }

  Widget _buildPayment(Callback onPress, String iconNotPick, String iconPick, String title, String des, bool isSelected) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: UIColors.white,
          borderRadius: BorderRadius.circular(
            DimensManager.dimens.setRadius(10),
          ),
          border: Border.all(width: 1, color: UIColors.border),
        ),
        padding: EdgeInsets.symmetric(
            vertical: DimensManager.dimens.setHeight(10),
            horizontal: DimensManager.dimens.setWidth(5)),
        margin: EdgeInsets.only(bottom: DimensManager.dimens.setHeight(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            isSelected
                ? Image.asset(
                    iconPick,
                    width: DimensManager.dimens.setWidth(48),
                    height: DimensManager.dimens.setHeight(48),
                  )
                : Image.asset(
                    iconNotPick,
                    width: DimensManager.dimens.setWidth(48),
                    height: DimensManager.dimens.setHeight(48),
                  ),
            SizedBox(
              width: DimensManager.dimens.setWidth(10),
            ),
            SizedBox(
              width: DimensManager.dimens.setWidth(260),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UITitle(
                    title,
                    size: DimensManager.dimens.setSp(18),
                  ),
                  UIText(des, size: DimensManager.dimens.setSp(14))
                ],
              ),
            ),
            isSelected
                ? Image.asset(
                    AssetIcons.iconTick,
                    width: DimensManager.dimens.setWidth(36),
                    height: DimensManager.dimens.setHeight(36),
                  )
                : Container(
                    width: DimensManager.dimens.setWidth(36),
                  ),
          ],
        ),
      ),
    );
  }
}
