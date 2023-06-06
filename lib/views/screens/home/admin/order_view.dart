import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/enums/enum.dart';
import 'package:sahami_app/services/navigation_service.dart';
import 'package:sahami_app/viewmodel/order_view_model.dart';
import 'package:sahami_app/views/containers/order_list_view.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import '../../../../data/data_local.dart';
import '../../../../data/remote/entity/order_entity.dart';
import '../../../../utils/constants.dart';
import '../../../assets/asset_icons.dart';
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

  @override
  void initState() {
    _orderViewModel.fetchOrderStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _orderViewModel,
      child: Consumer<OrderViewModel>(
        builder: (_, viewModel, __) {
          return Scaffold(
            backgroundColor: UIColors.white,
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
                SizedBox(
                  height: DimensManager.dimens.setHeight(20),
                ),
                Container(
                  height: DimensManager.dimens.setHeight(50),
                  margin: EdgeInsets.only(
                    left: DimensManager.dimens.setWidth(20),
                  ),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: OrderStatus.values.length,
                      itemBuilder: (context, index) => _buildTabStatus(
                          index, viewModel.selectedIndex, viewModel)),
                ),
                Expanded(
                  child: PageView(
                    controller: viewModel.pageController,
                    onPageChanged: (int page) {
                      viewModel.onChangePage(page);
                    },
                    children: [
                      _buildListOrder(viewModel.orderPendingList, UIStrings.pending, viewModel),
                      _buildListOrder(viewModel.confirmList, UIStrings.confirmed, viewModel),
                      _buildListOrder(viewModel.pendingDelivery, UIStrings.delivering, viewModel),
                      _buildListOrder(viewModel.orderListFinish, UIStrings.finish, viewModel),
                    ],
                  ),
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
        viewModel.pageController.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      },
      child: Container(
        margin: EdgeInsets.only(
          right: DimensManager.dimens.setWidth(15),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: DimensManager.dimens.setWidth(15),
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(DimensManager.dimens.setRadius(30)),
            color: selected == index
                ? UIColors.primarySecond
                : UIColors.background),
        child: UIText(
          OrderStatus.values[index].nameOrder,
          size: DimensManager.dimens.setSp(14),
          color: selected == index ? UIColors.white : UIColors.text,
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
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                width: 3, color: UIColors.background),
          ),
        ),
      ),
    );
  }

  Widget _buildListOrder(List<OrderEntity> list, String orderStatus, OrderViewModel viewModel) {
    final formatter = intl.NumberFormat.decimalPattern();
    return viewModel.viewState == ViewState.busy ?
        const Center(child: CircularProgressIndicator(),)
        : list.isEmpty
        ? Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: DimensManager.dimens.setHeight(30)),
      child: Column(
        children: [
          Image.asset(
            AssetIcons.iconOrderEmpty,
            width: DimensManager.dimens.setWidth(100),
            height: DimensManager.dimens.setHeight(100),
            fit: BoxFit.cover,
          ),
          const UIText(
            UIStrings.myOrderEmptyAdmin,
            textAlign: TextAlign.center,
          )
        ],
      ),
    )
        : ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              NavigationServices.instance.navigationToOrderDetailScreen(
                context,
                arguments: {
                  Constants.ENTITY: list.elementAt(index),
                  Constants.STATUS: orderStatus
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
                  color: UIColors.primaryBackground),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIText("Order ID ${list[index].orderId}",
                      color: UIColors.black),
                  SizedBox(height: DimensManager.dimens.setHeight(10)),
                  UIText("${list[index].items.length} món"),
                  SizedBox(height: DimensManager.dimens.setHeight(10)),
                  UIText(DateFormat('hh:mm a dd/MM/yyy').format(list[index].createAt!.toDate()),),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: UIText(
                          "${formatter.format(list[index].orderAmount)} VNĐ"))
                ],
              ),
            ),
          );
        });
  }
}
