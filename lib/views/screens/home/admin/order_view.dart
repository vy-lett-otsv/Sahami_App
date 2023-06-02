import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/enums/enum.dart';
import 'package:sahami_app/services/navigation_service.dart';
import 'package:sahami_app/viewmodel/order_view_model.dart';
import 'package:sahami_app/views/containers/order_list_view.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import '../../../../data/data_local.dart';
import '../../../../data/remote/entity/order_entity.dart';
import '../../../../utils/constants.dart';
import '../../../constants/dimens_manager.dart';
import '../../../constants/ui_color.dart';
import '../../../constants/ui_strings.dart';
import 'package:intl/intl.dart' as intl;

class OrderView extends StatefulWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView>
    with SingleTickerProviderStateMixin {
  final OrderViewModel _orderViewModel = OrderViewModel();
  // late TabController _tabController;
  final PageController _pageController = PageController(initialPage: 0);
  int _activePage = 0;

  @override
  void initState() {
    _orderViewModel.fetchOrderStatus();
    // _tabController = TabController(vsync: this, length: DataLocal.orderStatus.length);
    // _tabController.addListener(() {
    //   _orderViewModel.changeStaffTab(_tabController.index);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _orderViewModel,
      child: Consumer<OrderViewModel>(
        builder: (_, viewModel, __) {
          return Scaffold(
            backgroundColor: UIColors.background,
            appBar: AppBar(
              title: const Text(UIStrings.manageOrder),
              backgroundColor: UIColors.primary,
              centerTitle: true,
              automaticallyImplyLeading: false,
              actions: [
                GestureDetector(onTap: () {}, child: const Icon(Icons.add)),
                SizedBox(width: DimensManager.dimens.setWidth(20))
              ],
            ),
            body: Column(
              children: [
                _buildSearch(context),
                SizedBox(height: DimensManager.dimens.setHeight(10),),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: OrderStatus.values.length,
                    itemBuilder: (context, index) => _buildTabStatus(
                        index, viewModel.selectedIndex, viewModel)
                  ),
                ),
                Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _activePage = page;
                        });
                      },
                      children: [
                        _buildListOrder(viewModel.orderPendingList),
                        _buildListOrder(viewModel.confirmList),
                        _buildListOrder(viewModel.pendingDelivery),
                      ],
                    )
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabStatus(int index, int selected, OrderViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        viewModel.updateSelected(index);
        _pageController.animateToPage(
            index, duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn);
      },
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: DimensManager.dimens.setWidth(10)),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: DimensManager.dimens.setWidth(10),
            vertical: DimensManager.dimens.setHeight(5)
          ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(10)),
              color: selected == index ? UIColors.primary : UIColors.background
            ),
            child: UIText(OrderStatus.values[index].name, size: DimensManager.dimens.setSp(14), color: selected == index ? UIColors.textDart : UIColors.text,),
        ),
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return Container(
      color: UIColors.white,
      child: TextField(
        decoration: InputDecoration(
          labelText: UIStrings.search,
          prefixIcon: Icon(Icons.search, color: UIColors.text),
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: EdgeInsets.zero,
        ),
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
                        UIText("${list[index].items.length} món")
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
                            list[index].orderStatus,
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
