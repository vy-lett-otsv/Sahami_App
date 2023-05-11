import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/viewmodel/widget/bottomsheet_add_item_view_model.dart';
import '../../../data/data_local.dart';
import '../../constants/dimens_manager.dart';
import '../../constants/ui_color.dart';
import '../../constants/ui_strings.dart';
import '../ui_text.dart';
import '../ui_title.dart';
import 'package:flutter/material.dart';

class BottomSheetAddItem extends StatefulWidget {
  const BottomSheetAddItem({Key? key}) : super(key: key);

  @override
  State<BottomSheetAddItem> createState() => _BottomSheetAddItemState();
}

class _BottomSheetAddItemState extends State<BottomSheetAddItem> {
  final BottomSheetAddItemViewModel _bottomSheetAddItemViewModel = BottomSheetAddItemViewModel();

  @override
  void initState() {
    _bottomSheetAddItemViewModel.initProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _bottomSheetAddItemViewModel,
      child: Consumer<BottomSheetAddItemViewModel>(
        builder: (_, viewModel, __) {
          return FractionallySizedBox(
            heightFactor: DimensManager.dimens.setHeight(1.5),
            child: Container(
              color: UIColors.white,
              margin: EdgeInsets.only(
                bottom: DimensManager.dimens.setHeight(100),
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                    EdgeInsets.only(top: DimensManager.dimens.setHeight(10)),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSize(viewModel),
                          SizedBox(height: DimensManager.dimens.setHeight(20),),
                          _buildOption(UIStrings.ice, DataLocal.ice.first, DataLocal.ice, viewModel.valueIce),
                          SizedBox(height: DimensManager.dimens.setHeight(20),),
                          // _buildOption(UIStrings.quantitySugar, DataLocal.sugar.first, DataLocal.sugar),
                          SizedBox(height: DimensManager.dimens.setHeight(20),),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: DimensManager.dimens.setWidth(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const UIText(UIStrings.flavor, fontWeight: FontWeight.bold),
                                SizedBox(height: DimensManager.dimens.setHeight(10),),
                                const UIText(UIStrings.syrup, size: 14,),
                                const Divider(),
                                _buildQuantity(
                                    UIStrings.brownSugar,
                                    UIStrings.addBrownSugar,
                                    viewModel,
                                    viewModel.brownSugarSyrup,
                                    viewModel.setQuantity(true, true, false, false),
                                ),
                                // _buildQuantity(
                                //     UIStrings.brownSugar,
                                //     UIStrings.addBrownSugar,
                                //     viewModel,
                                //     viewModel.caramelSyrup,
                                //     viewModel.setQuantity(true, false, true, false),
                                //     viewModel.setQuantity(false, false, true, false)
                                // ),
                                // _buildQuantity(
                                //     UIStrings.brownSugar,
                                //     UIStrings.addBrownSugar,
                                //     viewModel,
                                //     viewModel.vanillaSyrup,
                                //     viewModel.setQuantity(true, false, false, true),
                                //     viewModel.setQuantity(false, false, false, true),
                                // ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )
    );
  }

  Widget _buildSize(BottomSheetAddItemViewModel bottomSheetAddItemViewModel) {
    return Container(
      height: DimensManager.dimens.setHeight(170),
      padding: EdgeInsets.symmetric(horizontal: DimensManager.dimens.setWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UIText(UIStrings.size, fontWeight: FontWeight.bold),
          SizedBox(height: DimensManager.dimens.setHeight(10),),
          Expanded(
            child: Center(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: DataLocal.cupSize.length,
                    itemBuilder: (context, index) {
                      final iconCupSize = DataLocal.cupSize[index];
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: DimensManager.dimens.setWidth(15)),
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
                                    color: iconCupSize.isSelected ?  UIColors.primarySecond: UIColors.background),
                                padding: EdgeInsets.symmetric(
                                    horizontal: DimensManager.dimens.setWidth(20),
                                    vertical: DimensManager.dimens.setWidth(5)),
                                child: UIText(
                                  iconCupSize.price,
                                  fontWeight: FontWeight.bold,
                                  size: 14, color: iconCupSize.isSelected ?  UIColors.white: UIColors.text,
                                ),
                              ),
                              onTap: () {
                                bottomSheetAddItemViewModel.updateSelectedSize(index);
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

  Widget _buildOption(String title, String dropdownValue, List<String> data, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DimensManager.dimens.setWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIText(title, fontWeight: FontWeight.bold),
          SizedBox(
            height: DimensManager.dimens.setHeight(10),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: DimensManager.dimens.setWidth(10)),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: UIColors.primary),
                borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(10))),
            width: DimensManager.dimens.fullWidth,
            child: DropdownButton(
              value: dropdownValue,
              icon: const Icon(Icons.keyboard_arrow_down),
              elevation: 16,
              isExpanded: true,
              underline: Container(
                color: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  // dropdownValue = value;
                });
              },
              items: data.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: UIText(value, size: DimensManager.dimens.setSp(18),),
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
            borderRadius:
            BorderRadius.circular(28 / 2),
            color: UIColors.white,
            border: Border.all(
                width: 1,
                color: UIColors.primary)),
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
      int pump,
      void onPressAdd,
      // void onPressRemove
      ) {
    print("build Quantity ${bottomSheetAddItemViewModel.quantity}");
    return Container(
      margin: EdgeInsets.only(
        bottom: DimensManager.dimens.setHeight(20),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: DimensManager.dimens.setWidth(10),
          vertical: DimensManager.dimens.setHeight(10)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              DimensManager.dimens.setRadius(10)),
          border: Border.all(width: 1, color: UIColors.primary)),
      child: pump!= 0?
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UIText(titleDefault, size: DimensManager.dimens.setSp(18),),
          SizedBox(
            width: DimensManager.dimens.setWidth(90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIcon(Icons.remove, () {
                  // onPressRemove;
                }),
                SizedBox(width: DimensManager.dimens.setWidth(5),),
                UIText(pump.toString()),
                SizedBox(width: DimensManager.dimens.setWidth(5),),
                _buildIcon(Icons.add, () {
                  onPressAdd;
                }),
              ],
            ),
          )
        ],
      )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UIText(titleAfter, size: DimensManager.dimens.setSp(18),),
                _buildIcon(Icons.add, () {
                  onPressAdd;
                }),
        ],
      ),
    );
  }
}
