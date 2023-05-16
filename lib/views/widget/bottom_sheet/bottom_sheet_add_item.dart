import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/data/remote/enitity/product_entity.dart';
import 'package:sahami_app/viewmodel/widget/botttom_sheet_add_item_view_model.dart';
import 'package:sahami_app/views/widget/ui_button_primary.dart';
import 'package:sahami_app/views/widget/ui_text_price.dart';
import '../../../data/data_local.dart';
import '../../constants/dimens_manager.dart';
import '../../constants/ui_color.dart';
import '../../constants/ui_strings.dart';
import '../ui_icon_button.dart';
import '../ui_text.dart';
import '../ui_title.dart';
import 'package:flutter/material.dart';

class BottomSheetAddItem extends StatefulWidget {
  final ProductEntity productEntity;

  const BottomSheetAddItem({Key? key, required this.productEntity})
      : super(key: key);

  @override
  State<BottomSheetAddItem> createState() => _BottomSheetAddItemState();
}

class _BottomSheetAddItemState extends State<BottomSheetAddItem> {
  final BottomSheetAddItemViewModel _cartViewModel = BottomSheetAddItemViewModel();

  @override
  Widget build(BuildContext context) {
    _cartViewModel.initProduct();
    return ChangeNotifierProvider(
        create: (_) => _cartViewModel,
        child: Consumer<BottomSheetAddItemViewModel>(
          builder: (_, viewModel, __) {
            return FractionallySizedBox(
              heightFactor: DimensManager.dimens.setHeight(1.5),
              child: Container(
                color: UIColors.white,
                margin: EdgeInsets.only(
                  bottom: DimensManager.dimens.setHeight(80),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: DimensManager.dimens.setHeight(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: DimensManager.dimens.setWidth(44)),
                          const UITitle(UIStrings.addNewItem),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.close, size: 24),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: DimensManager.dimens.setWidth(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: DimensManager.dimens.setHeight(20)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    UITitle(
                                      widget.productEntity.productName,
                                    ),
                                    SizedBox(
                                      height: DimensManager.dimens.setHeight(10),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        widget.productEntity.priceSale != 0
                                            ? UITextPrice(
                                          price: widget.productEntity.price,
                                          priceSale: widget.productEntity.priceSale,
                                          isPriceSale: true,
                                          color: UIColors.primary,
                                        )
                                            : UITextPrice(
                                          price: widget.productEntity.price,
                                          color: UIColors.primary,
                                        ),
                                        SizedBox(
                                          width: DimensManager.dimens.setWidth(120),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              UIIconButton(
                                                icon: Icons.remove,
                                                radius:
                                                DimensManager.dimens.setSp(36),
                                                backgroundColor:
                                                UIColors.primarySecond,
                                                iconColor: UIColors.white,
                                                circle: false,
                                                onPressed: () {
                                                  viewModel.setQuantity(false);
                                                },
                                              ),
                                              UIText("${viewModel.optionEntity.quantity}"),
                                              UIIconButton(
                                                icon: Icons.add,
                                                radius:
                                                DimensManager.dimens.setSp(36),
                                                backgroundColor:
                                                UIColors.primarySecond,
                                                iconColor: UIColors.white,
                                                circle: false,
                                                onPressed: () {
                                                  viewModel.setQuantity(true);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
                              _buildSize(viewModel),
                              SizedBox(
                                height: DimensManager.dimens.setHeight(20),
                              ),
                              _buildOptionDefault(
                                  UIStrings.ice, viewModel.optionEntity.ice,
                                  (value) {
                                viewModel.setIce(value);
                              }, DataLocal.ice),
                              _buildOptionDefault(UIStrings.quantitySugar,
                                  viewModel.optionEntity.sugar, (value) {
                                viewModel.setSugar(value);
                              }, DataLocal.sugar),
                              SizedBox(
                                height: DimensManager.dimens.setHeight(20),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const UIText(UIStrings.flavor,
                                      fontWeight: FontWeight.bold),
                                  SizedBox(
                                    height: DimensManager.dimens.setHeight(10),
                                  ),
                                  const UIText(
                                    UIStrings.syrup,
                                    size: 14,
                                  ),
                                  const Divider(),
                                  _buildQuantity(
                                      UIStrings.brownSugar,
                                      UIStrings.addBrownSugar,
                                      viewModel,
                                      viewModel.optionEntity.brownSugarSyrup,
                                      () {
                                    viewModel.setQuantityBrownSugarSyrup(false);
                                  }, () {
                                    viewModel.setQuantityBrownSugarSyrup(true);
                                  }),
                                  _buildQuantity(
                                      UIStrings.brownSugar,
                                      UIStrings.addBrownSugar,
                                      viewModel,
                                      viewModel.optionEntity.caramelSyrup != 0
                                          ? viewModel.optionEntity.caramelSyrup
                                          : 0, () {
                                    viewModel.setQuantityCaramelSyrup(false);
                                  }, () {
                                    viewModel.setQuantityCaramelSyrup(true);
                                  }),
                                  _buildQuantity(
                                      UIStrings.brownSugar,
                                      UIStrings.addBrownSugar,
                                      viewModel,
                                      viewModel.optionEntity.vanillaSyrup, () {
                                    viewModel.setQuantityVanillaSyrup(false);
                                  }, () {
                                    viewModel.setQuantityVanillaSyrup(true);
                                  }),
                                  const UIText(
                                    UIStrings.toppings,
                                    size: 14,
                                  ),
                                  _buildOption(
                                      viewModel.optionEntity.cookieCrumbleTopping, (value) {
                                    viewModel.setCookieCrumbleTopping(value);
                                  },
                                      DataLocal.cookieCrumbleTopping,
                                      UIStrings.cookieCrumbleTopping)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: DimensManager.dimens.setHeight(10)),
                      child: UIButtonPrimary(
                          text: UIStrings.addCart,
                          onPress: () {
                            viewModel.addProductList(widget.productEntity, context);
                          }),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget _buildSize(BottomSheetAddItemViewModel viewModel) {
    return SizedBox(
      height: DimensManager.dimens.setHeight(200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: DimensManager.dimens.setHeight(50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const UIText(UIStrings.size, fontWeight: FontWeight.bold),
                if (viewModel.isSelected)
                  UIButtonPrimary(
                    text: UIStrings.refresh,
                    paddingHorizontal: 20,
                    paddingVertical: 0,
                    isBorder: true,
                    backgroundColor: UIColors.white,
                    textColor: UIColors.primary,
                    onPress: () {
                      viewModel.initProduct();
                    },
                  )
                else
                  Container()
              ],
            ),
          ),
          SizedBox(
            height: DimensManager.dimens.setHeight(10),
          ),
          Expanded(
            child: Center(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: DataLocal.cupSize.length,
                    itemBuilder: (context, index) {
                      final iconCupSize = DataLocal.cupSize[index];
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: DimensManager.dimens.setWidth(15)),
                        child: Column(
                          children: [
                            Image.asset(
                              iconCupSize.image,
                              width: DimensManager.dimens.setWidth(80),
                              height: DimensManager.dimens.setHeight(80),
                            ),
                            SizedBox(
                              height: DimensManager.dimens.setHeight(10),
                            ),
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        DimensManager.dimens.setRadius(30)),
                                    color: iconCupSize.isSelected
                                        ? UIColors.primarySecond
                                        : UIColors.background),
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        DimensManager.dimens.setWidth(20),
                                    vertical: DimensManager.dimens.setWidth(5)),
                                child: UIText(
                                  iconCupSize.price,
                                  fontWeight: FontWeight.bold,
                                  size: 14,
                                  color: iconCupSize.isSelected
                                      ? UIColors.white
                                      : UIColors.text,
                                ),
                              ),
                              onTap: () {
                                viewModel.updateSelectedSize(
                                    index, iconCupSize.name);
                              },
                            )
                          ],
                        ),
                      );
                    })),
          )
        ],
      ),
    );
  }

  Widget _buildOption(String? value, Function(String?) onPress,
      List<String> list, String hint) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: DimensManager.dimens.setHeight(10)),
      padding:
          EdgeInsets.symmetric(horizontal: DimensManager.dimens.setWidth(10)),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: UIColors.primary),
          borderRadius:
              BorderRadius.circular(DimensManager.dimens.setRadius(10))),
      width: DimensManager.dimens.fullWidth,
      child: DropdownButton<String>(
        hint: UIText(
          hint,
          size: DimensManager.dimens.setSp(18),
        ),
        value: value,
        icon: const Icon(Icons.keyboard_arrow_down),
        elevation: 16,
        isExpanded: true,
        underline: Container(
          color: Colors.white,
        ),
        onChanged: onPress,
        items: list.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: UIText(
              value,
              size: DimensManager.dimens.setSp(18),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOptionDefault(String title, String? value,
      Function(String?) onPress, List<String> list) {
    return Container(
      margin: EdgeInsets.only(bottom: DimensManager.dimens.setHeight(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIText(title, fontWeight: FontWeight.bold),
          SizedBox(
            height: DimensManager.dimens.setHeight(10),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: DimensManager.dimens.setWidth(10)),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: UIColors.primary),
                borderRadius:
                    BorderRadius.circular(DimensManager.dimens.setRadius(10))),
            width: DimensManager.dimens.fullWidth,
            child: DropdownButton<String>(
              value: value,
              icon: const Icon(Icons.keyboard_arrow_down),
              elevation: 16,
              isExpanded: true,
              underline: Container(
                color: Colors.white,
              ),
              onChanged: onPress,
              items: list.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: UIText(
                    value,
                    size: DimensManager.dimens.setSp(18),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon, Callback onPress) {
    return Container(
        width: DimensManager.dimens.setWidth(28),
        height: DimensManager.dimens.setHeight(28),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28 / 2),
            color: UIColors.white,
            border: Border.all(width: 1, color: UIColors.primary)),
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            icon,
            color: UIColors.primary,
            size: DimensManager.dimens.setSp(24),
          ),
          onPressed: onPress,
        ));
  }

  Widget _buildQuantity(
    String titleDefault,
    String titleAfter,
    BottomSheetAddItemViewModel bottomSheetAddItemViewModel,
    int? pump,
    Callback onPressRemove,
    Callback onPressAdd,
  ) {
    return Container(
      margin: EdgeInsets.only(
        bottom: DimensManager.dimens.setHeight(20),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: DimensManager.dimens.setWidth(10),
          vertical: DimensManager.dimens.setHeight(10)),
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(DimensManager.dimens.setRadius(10)),
          border: Border.all(width: 1, color: UIColors.primary)),
      child: pump != 0
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UIText(
                  titleDefault,
                  size: DimensManager.dimens.setSp(18),
                ),
                SizedBox(
                  width: DimensManager.dimens.setWidth(90),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildIcon(Icons.remove, onPressRemove),
                      SizedBox(
                        width: DimensManager.dimens.setWidth(5),
                      ),
                      UIText(pump.toString()),
                      SizedBox(
                        width: DimensManager.dimens.setWidth(5),
                      ),
                      _buildIcon(Icons.add, onPressAdd),
                    ],
                  ),
                )
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UIText(
                  titleAfter,
                  size: DimensManager.dimens.setSp(18),
                ),
                _buildIcon(Icons.add, onPressAdd)
              ],
            ),
    );
  }
}
