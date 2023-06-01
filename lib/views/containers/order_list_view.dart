import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:sahami_app/viewmodel/order_view_model.dart';

import '../../data/remote/entity/order_entity.dart';
import '../../services/navigation_service.dart';
import '../../utils/constants.dart';
import '../constants/dimens_manager.dart';
import '../constants/ui_color.dart';
import '../widget/ui_text.dart';

class OrderListView extends StatelessWidget {
  final int selected;
  final OrderViewModel orderViewModel;
  const OrderListView({Key? key, required this.selected, required this.orderViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => orderViewModel,
      child: Consumer<OrderViewModel>(
        builder: (_, viewModel, __) {
          print(orderViewModel.selectedIndex);
          print(viewModel.pageController.toString());
          return Expanded(
              child: PageView(
                controller: viewModel.pageController,
                // onPageChanged: (index) {
                //   index = orderViewModel.selected;
                //   print(index);
                // },
                children: [
                  _buildListOrder(orderViewModel.orderPendingList),
                  _buildListOrder(orderViewModel.confirmList),
                  _buildListOrder(orderViewModel.pendingDelivery),
                ],
              ));
        },
      ),
    );
  }

  Widget _buildListOrder(List<OrderEntity> list) {
    final formatter = intl.NumberFormat.decimalPattern();
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: list.length,
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
                    onPressed: (context) {}),
                const Spacer(),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                NavigationServices.instance.navigationToOrderDetailScreen(
                  context,
                  arguments: {
                    Constants.ENTITY:
                    list.elementAt(index),
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: DimensManager.dimens.setWidth(20),
                    vertical: DimensManager.dimens.setWidth(10)),
                margin: EdgeInsets.symmetric(
                  vertical: DimensManager.dimens.setHeight(10),
                  horizontal: DimensManager.dimens.setWidth(20),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        DimensManager.dimens.setSp(20)),
                    color: UIColors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UIText(
                        "Order ID ${list[index].orderId}",
                        color: UIColors.black),
                    SizedBox(height: DimensManager.dimens.setHeight(10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // UIText(
                        //     "${list[index].createAt}, ${list[index].createAtTime}",
                        //     size: DimensManager.dimens.setSp(14)),
                        UIText(
                            "${list[index].items.length} món")
                      ],
                    ),
                    SizedBox(height: DimensManager.dimens.setHeight(10)),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                DimensManager.dimens.setSp(10)),
                            border: Border.all(
                                width: 1, color: UIColors.primary)),
                        padding: EdgeInsets.symmetric(
                            horizontal: DimensManager.dimens.setWidth(10),
                            vertical: DimensManager.dimens.setHeight(5)),
                        child: UIText(
                            orderViewModel
                                .orderPendingList[index].orderStatus,
                            color: UIColors.primary,
                            size: DimensManager.dimens.setSp(14))),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: UIText(
                            "${formatter.format(list[index].orderAmount)} VNĐ"))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
