import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/data/remote/entity/order_entity.dart';
import 'package:sahami_app/viewmodel/order_view_model.dart';
import 'package:sahami_app/viewmodel/payment_view_model.dart';
import 'package:sahami_app/views/widget/ui_button_order.dart';
import 'package:sahami_app/views/widget/ui_title.dart';
import '../../../constants/dimens_manager.dart';
import '../../../constants/ui_color.dart';
import '../../../constants/ui_strings.dart';
import '../../../widget/ui_text.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetailView extends StatefulWidget {
  final OrderEntity orderEntity;
  final String status;

  const OrderDetailView({Key? key, required this.orderEntity, required this.status})
      : super(key: key);

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  final OrderViewModel _orderViewModel = OrderViewModel();
  final PaymentViewModel _paymentViewModel = PaymentViewModel();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _orderViewModel),
        ChangeNotifierProvider(create: (_) => _paymentViewModel),
      ],
      child: Consumer<OrderViewModel>(
        builder: (_, viewModel, __) {
          final formatter = intl.NumberFormat.decimalPattern();
          return Scaffold(
            appBar: AppBar(
              title: const Text(UIStrings.detailOrder),
              backgroundColor: UIColors.primary,
              centerTitle: true,
              leading: GestureDetector(
                child: const Icon(Icons.arrow_back_ios),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: DimensManager.dimens.setWidth(20)),
              margin: EdgeInsets.only(top: DimensManager.dimens.setHeight(10)),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.orderEntity.items.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                            vertical: DimensManager.dimens.setHeight(10),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: DimensManager.dimens.setHeight(10),
                          ),
                          constraints: BoxConstraints(
                            minHeight: DimensManager.dimens.setHeight(100),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(20)),
                              color: UIColors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(10)),
                                    child: Image.network(
                                      widget.orderEntity.items[index]['image'],
                                      width: DimensManager.dimens.setWidth(80),
                                      height: DimensManager.dimens.setHeight(80),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: DimensManager.dimens.setWidth(10),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      UIText(
                                        widget.orderEntity.items[index]['name_product'],
                                        fontWeight: FontWeight.bold,
                                        size: DimensManager.dimens.setSp(18),
                                      ),
                                      SizedBox(
                                        height:
                                            DimensManager.dimens.setHeight(10),
                                      ),
                                      UIText(
                                        'Số lượng ${widget.orderEntity.items[index]['quantity']}',
                                        size: DimensManager.dimens.setSp(16),
                                      ),
                                      SizedBox(
                                        height:
                                            DimensManager.dimens.setHeight(10),
                                      ),
                                      UIText(
                                        '${widget.orderEntity.items[index]['size']}',
                                        size: DimensManager.dimens.setSp(16),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: DimensManager.dimens.setHeight(10),
                              ),
                              Consumer<PaymentViewModel>(
                                builder: (_, viewModel, __) {
                                  viewModel.displayTextOrder(index, widget.orderEntity);
                                  Map<String, dynamic> map = viewModel.getNamedSyrup(true);
                                  return map.length == 1 && map.keys.first == 'size'
                                      ? Container()
                                      : Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(DimensManager.dimens.setRadius(10)),
                                              border: Border.all(width: 1, color: UIColors.primary)),
                                          padding: EdgeInsets.all(DimensManager.dimens.setHeight(10)),
                                          alignment: Alignment.center,
                                          child: UIText(viewModel.getNamedSyrup(false).values.join('\n'),
                                            fontWeight: FontWeight.w100,
                                            size: DimensManager.dimens.setSp(16),
                                          ),
                                  );
                                },
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(20)),
                        color: UIColors.primaryBackground),
                    padding: EdgeInsets.symmetric(
                        horizontal: DimensManager.dimens.setWidth(15),
                        vertical: DimensManager.dimens.setHeight(10)
                    ),
                    child: Column(
                      children: [
                        _buildInformation(UIStrings.nameUser, widget.orderEntity.userEntity.userName),
                        _buildInformation(UIStrings.phone, widget.orderEntity.userEntity.contact),
                        _buildInformation(UIStrings.address, widget.orderEntity.userEntity.address),
                        _buildInformation(UIStrings.note,
                            widget.orderEntity.orderNote == ''
                                ? UIStrings.notNotice
                                : widget.orderEntity.orderNote),
                        Divider(color: UIColors.backgroundInput,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const UIText(UIStrings.totalAmount),
                            SizedBox(
                              width: DimensManager.dimens.setWidth(10),
                            ),
                            UITitle(
                                '${formatter.format(widget.orderEntity.orderAmount)} VNĐ',
                              fontWeight: FontWeight.bold,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: DimensManager.dimens.setHeight(20),
                      horizontal: DimensManager.dimens.setWidth(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UIButtonOrder(
                            callback: () {
                              viewModel.updateStatusOrder(UIStrings.cancelOrder, widget.orderEntity.orderId);
                            },
                            text: UIStrings.cancelOrderButton, backgroundColor: UIColors.white, textColor: UIColors.text,
                        ),
                        UIButtonOrder(
                          callback: () {
                            viewModel.updateStatusOrder(UIStrings.confirmed, widget.orderEntity.orderId);
                            viewModel.notificationSuccess(context);
                          },
                          text: UIStrings.confirmOrder,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInformation(String title, String? text) {
    return Container(
      margin: EdgeInsets.only(bottom: DimensManager.dimens.setHeight(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UIText(title, size: DimensManager.dimens.setSp(16),),
          UIText(text!, size: DimensManager.dimens.setSp(18), color: UIColors.textDart,)
        ],
      ),
    );
  }
}
