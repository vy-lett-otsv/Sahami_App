import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sahami_app/viewmodel/customer_view_model.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import '../../../enums/view_state.dart';
import '../../../services/navigation_service.dart';
import '../../../utils/constants.dart';
import '../../constants/ui_color.dart';
import '../../constants/ui_strings.dart';
import '../../widget/bottomsheet_model.dart';
import 'package:provider/provider.dart';

class CustomerView extends StatefulWidget {
  const CustomerView({Key? key}) : super(key: key);

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  final CustomerViewModel _customerViewModel = CustomerViewModel();

  @override
  void initState() {
    _customerViewModel.fetchCustomer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => _customerViewModel)],
      child: Scaffold(
        backgroundColor: UIColors.background,
        appBar: AppBar(
          title: const Text(UIStrings.manageCustomer),
          backgroundColor: UIColors.primary,
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _customerViewModel.goToScreenCreateCustomerView(context);
                },
                child: const Icon(Icons.add)
            ),
            SizedBox(width: DimensManager.dimens.setWidth(20))
          ],
        ),
        body: SafeArea(
            child: Consumer<CustomerViewModel> (
              builder: (_, customerViewModel, __) {
                return Column(
                  children: [
                    _buildSearch(context),
                    customerViewModel.viewState == ViewState.busy?
                    const Expanded(
                        child: Center(
                            child: CircularProgressIndicator()
                        )
                    )
                    : _buildListCustomer(context, customerViewModel)
                  ],
                );
              },
            )
        ),
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
              onTap: () {
                BottomSheetDialog.showCustomerDialog(context: context);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListCustomer(BuildContext context, CustomerViewModel customerViewModel) {
    return customerViewModel.userList.isEmpty ?
      Container(
        margin: EdgeInsets.only(top: DimensManager.dimens.setHeight(20)),
          child: const UIText(UIStrings.isEmptyCustomer)
      )
    :Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: customerViewModel.userList.length,
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
                        onPressed: (context) {
                            _customerViewModel.deleteCustomer(customerViewModel.userList[index].userId);
                        }
                    ),
                    const Spacer(),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    NavigationServices.instance.navigationToCustomerDetailScreen(
                      context,
                      arguments: {
                        Constants.ENTITY: customerViewModel.userList.elementAt(index),
                      },
                    );
                  },
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
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(DimensManager.dimens.setSp(20)),
                          child:  Image.network(customerViewModel.userList[index].image,
                            width: DimensManager.dimens.setWidth(80),
                            height: DimensManager.dimens.setHeight(80),
                            fit: BoxFit.cover),
                        ),
                        SizedBox(width: DimensManager.dimens.setWidth(20)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                customerViewModel.userList[index].userName,
                                style: TextStyle(fontSize: DimensManager.dimens.setSp(18), color: UIColors.black)
                            ),
                            SizedBox(height: DimensManager.dimens.setHeight(10)
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: DimensManager.dimens.setHeight(5)
                              ),
                              child: Text(customerViewModel.userList[index].contact,
                                  style: TextStyle(color: UIColors.text)),
                            )
                          ],
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