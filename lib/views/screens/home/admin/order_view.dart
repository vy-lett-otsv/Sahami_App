import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import '../../../constants/dimens_manager.dart';
import '../../../constants/ui_color.dart';
import '../../../constants/ui_strings.dart';

class OrderView extends StatefulWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.background,
      appBar: AppBar(
        title: const Text(UIStrings.manageCustomer),
        backgroundColor: UIColors.primary,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
              onTap: () {},
              child: const Icon(Icons.add)
          ),
          SizedBox(width: DimensManager.dimens.setWidth(20))
        ],
      ),
      body: SafeArea(
          child: Column(
            children: [
              _buildSearch(context),
              _buildListCustomer()
            ],
          )
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return Container(
      color: UIColors.white,
      child: Row(
        children: [
          Flexible(
            flex: 8,
            child: TextField(
              decoration: InputDecoration(
                labelText: UIStrings.search,
                prefixIcon: Icon(Icons.search, color: UIColors.text),
                border: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: GestureDetector(
              child: Icon(Icons.filter_list, color: UIColors.text),
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListCustomer() {
    return Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Slidable(
                endActionPane: ActionPane(
                  extentRatio: DimensManager.dimens.setWidth(0.2),
                  motion: const BehindMotion(),
                  children: [
                    SlidableAction(
                        backgroundColor: UIColors.background,
                        foregroundColor: UIColors.lightRed,
                        icon: Icons.delete,
                        onPressed: (context) {}
                    ),
                    const Spacer(),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: DimensManager.dimens.setWidth(20),
                        vertical: DimensManager.dimens.setWidth(10)
                    ),
                    margin: EdgeInsets.symmetric(
                      vertical: DimensManager.dimens.setHeight(10),
                      horizontal: DimensManager.dimens.setWidth(20),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(DimensManager.dimens.setSp(20)),
                        color: UIColors.white
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const UIText("Order ID #100001", color: UIColors.black),
                        SizedBox(height: DimensManager.dimens.setHeight(10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UIText("11-April-2023, 3:00 PM", size: DimensManager.dimens.setSp(14)),
                            const UIText("2 items")
                          ],
                        ),
                        SizedBox(height: DimensManager.dimens.setHeight(10)),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(DimensManager.dimens.setSp(10)),
                                border: Border.all(width: 1, color: UIColors.primary)
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: DimensManager.dimens.setWidth(10),
                                vertical: DimensManager.dimens.setHeight(5)
                            ),
                            child: UIText("New", color: UIColors.primary, size: DimensManager.dimens.setSp(14))
                        ),
                       const Align(
                         alignment: Alignment.bottomRight,
                           child: UIText("105, 000 VNĐ")
                       )
                      ],
                    ),
                  ),
                ),
              );
            }
        )
    );
  }
}
