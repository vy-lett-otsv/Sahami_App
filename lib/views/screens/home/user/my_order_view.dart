import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/enums/enum.dart';
import 'package:sahami_app/viewmodel/order_view_model.dart';
import 'package:sahami_app/views/assets/asset_icons.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import '../../../../data/data_local.dart';
import '../../../../data/remote/entity/order_entity.dart';
import '../../../../enums/fonts.dart';
import '../../../constants/dimens_manager.dart';
import '../../../constants/ui_color.dart';
import '../../../constants/ui_strings.dart';

class MyOrderView extends StatefulWidget {
  const MyOrderView({Key? key}) : super(key: key);

  @override
  State<MyOrderView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView>
    with SingleTickerProviderStateMixin {
  final OrderViewModel _orderViewModel = OrderViewModel();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: DataLocal.orderTabs.length);
    _orderViewModel.updateChangeTab(_tabController);
    _orderViewModel.formatDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => _orderViewModel)],
        child: Consumer<OrderViewModel>(
          builder: (_, orderViewModel, __) {
            return Scaffold(
              backgroundColor: UIColors.white,
              appBar: AppBar(
                title: const Text(UIStrings.myOrder),
                backgroundColor: UIColors.primary,
                centerTitle: true,
                automaticallyImplyLeading: false,
              ),
              body: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    tabs: DataLocal.orderTabs,
                    labelColor: UIColors.primary,
                    unselectedLabelColor: UIColors.yellow,
                    indicatorColor: UIColors.primary,
                    labelStyle: TextStyle(
                      fontFamily: Fonts.Inter,
                      fontWeight: FontWeight.w700,
                      fontSize: DimensManager.dimens.setSp(14),
                      letterSpacing: 1,
                    ),
                  ),
                  Expanded(
                      child: TabBarView(
                    controller: _tabController,
                    children: [
                      orderViewModel.viewState == ViewState.busy
                          ? const Center(child: CircularProgressIndicator())
                          : orderViewModel.orderList.isEmpty
                              ? Column(
                                  children: [
                                    Image.asset(
                                      AssetIcons.iconOrderEmpty,
                                      width: DimensManager.dimens.setWidth(200),
                                      height:
                                          DimensManager.dimens.setHeight(200),
                                      fit: BoxFit.cover,
                                    ),
                                    const UIText(UIStrings.myOrderEmpty)
                                  ],
                                )
                              : _buildListOrder(
                                  false, orderViewModel.orderList),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                orderViewModel.pickDateRange(context);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        DimensManager.dimens.setRadius(10)),
                                    color: UIColors.primary,
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          DimensManager.dimens.setWidth(10),
                                      vertical:
                                          DimensManager.dimens.setHeight(10)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          DimensManager.dimens.setWidth(10),
                                      vertical:
                                          DimensManager.dimens.setHeight(10)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      UIText(
                                        orderViewModel.date,
                                        color: UIColors.white,
                                        size: DimensManager.dimens.setSp(14),
                                      ),
                                      SizedBox(
                                        width: DimensManager.dimens.setWidth(5),
                                      ),
                                      Icon(
                                        Icons.calendar_today,
                                        size: DimensManager.dimens.setSp(24),
                                        color: UIColors.white,
                                      )
                                    ],
                                  )),
                            ),
                          ),
                          Expanded(
                              child: orderViewModel.orderListFinish.isEmpty
                                  ? Column(
                                      children: [
                                        Image.asset(
                                          AssetIcons.iconOrderEmpty,
                                          width: DimensManager.dimens
                                              .setWidth(200),
                                          height: DimensManager.dimens
                                              .setHeight(200),
                                          fit: BoxFit.cover,
                                        ),
                                        Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: DimensManager.dimens
                                                    .setWidth(40)),
                                            child: const UIText(
                                              UIStrings.myOrderFinishEmpty,
                                              textAlign: TextAlign.center,
                                            ))
                                      ],
                                    )
                                  : _buildListOrder(
                                      true, orderViewModel.orderListFinish))
                        ],
                      ),
                    ],
                  ))
                ],
              ),
            );
          },
        ));
  }

  Widget _buildListOrder(bool history, List<OrderEntity> orderList) {
    return ListView.separated(
      itemCount: orderList.length,
      itemBuilder: (context, index) {
        final formatterPrice = NumberFormat.decimalPattern();
        return Container(
            padding: EdgeInsets.symmetric(
                horizontal: DimensManager.dimens.setWidth(20),
                vertical: DimensManager.dimens.setHeight(10)),
            height: DimensManager.dimens.setHeight(210),
            color: UIColors.background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UIText(
                        "Order ${orderList[index].orderId}",
                        color: UIColors.textDart,
                      ),
                      UIText(orderList[index].createAt!)
                    ],
                  ),
                ),
                SizedBox(
                  height: DimensManager.dimens.setHeight(10),
                ),
                Flexible(
                  flex: 5,
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(
                              DimensManager.dimens.setRadius(15)),
                          child: Image.network(
                            orderList[index].items[0]['image'],
                            width: DimensManager.dimens.setWidth(100),
                            height: DimensManager.dimens.setHeight(120),
                            fit: BoxFit.cover,
                          )),
                      SizedBox(
                        width: DimensManager.dimens.setWidth(10),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UIText(
                              orderList[index].items[0]['name_product'],
                              color: UIColors.textDart,
                            ),
                            UIText('${orderList[index].items.length} món'),
                            UIText(
                              '${formatterPrice.format(orderList[index].orderAmount)} VNĐ',
                              fontWeight: FontWeight.bold,
                              color: UIColors.textDart,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            DimensManager.dimens.setWidth(5),
                                        vertical:
                                            DimensManager.dimens.setHeight(5)),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            DimensManager.dimens.setRadius(20)),
                                        border: Border.all(
                                            color: UIColors.primary)),
                                    child: UIText(
                                      '${orderList[index].orderStatus}',
                                      color: UIColors.primary,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                history
                    ? Flexible(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: DimensManager.dimens.setHeight(5),
                              left: DimensManager.dimens.setWidth(15)),
                          child: UIText(
                            UIStrings.rate,
                            color: UIColors.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ))
                    : Container()
              ],
            ));
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
