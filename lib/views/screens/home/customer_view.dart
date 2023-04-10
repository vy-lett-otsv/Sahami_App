import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import '../../constants/ui_color.dart';
import '../../constants/ui_strings.dart';
import '../../widget/bottomsheet_model.dart';
import '../../widget/ui_title.dart';

class CustomerView extends StatefulWidget {
  const CustomerView({Key? key}) : super(key: key);

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
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
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
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
              onTap: () {
                BottomSheetDialog.showCustomerDialog(context: context);
              },
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
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: DimensManager.dimens.setWidth(20),
                      vertical: DimensManager.dimens.setHeight(10)
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(10)),
                      color: UIColors.white
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(DimensManager.dimens.setWidth(5)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(10)),
                          child:  Image.network("https://i.pinimg.com/564x/e7/e2/d4/e7e2d422ccab3af6bb92cbd7dd099018.jpg",
                              width: DimensManager.dimens.setWidth(80),
                              height: DimensManager.dimens.setHeight(80)),
                        ),
                      ),
                      SizedBox(width: DimensManager.dimens.setWidth(10)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          const UITilte("Nguyen Van A", size: 18),
                          SizedBox(height: DimensManager.dimens.setHeight(10)),
                          const UIText("0924353647")
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
        )
    );
  }
}