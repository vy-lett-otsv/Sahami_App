import 'package:flutter/material.dart';
import 'package:sahami_app/views/assets/asset_icons.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import 'package:sahami_app/views/widget/ui_title.dart';
import '../../../constants/ui_strings.dart';

class CustomerDetailView extends StatefulWidget {
  const CustomerDetailView({Key? key}) : super(key: key);

  @override
  State<CustomerDetailView> createState() => _CustomerDetailViewState();
}

class _CustomerDetailViewState extends State<CustomerDetailView> {
  bool order = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.background,
      appBar: AppBar(
        title: const Text(UIStrings.customerDetail),
        backgroundColor: UIColors.primary,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
              onTap: () {},
              child: const Icon(Icons.edit)
          ),
          SizedBox(width: DimensManager.dimens.setWidth(20))
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: DimensManager.dimens.setWidth(20),
            vertical: DimensManager.dimens.setHeight(10)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: DimensManager.dimens.setHeight(100),
                padding: EdgeInsets.symmetric(
                  vertical: DimensManager.dimens.setHeight(10),
                    horizontal: DimensManager.dimens.setWidth(10)
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(20)),
                  color: UIColors.white
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(10)),
                      child:  Image.network("https://i.pinimg.com/564x/e7/e2/d4/e7e2d422ccab3af6bb92cbd7dd099018.jpg",
                          width: DimensManager.dimens.setWidth(80),
                          height: DimensManager.dimens.setHeight(80)),
                    ),
                    SizedBox(width: DimensManager.dimens.setWidth(20)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: DimensManager.dimens.setHeight(5)),
                        UIText("Lê Vy", size: DimensManager.dimens.setSp(20), color: UIColors.black),
                        Row(
                          children: [
                            Icon(Icons.phone_outlined, size: DimensManager.dimens.setSp(16)),
                            SizedBox(width: DimensManager.dimens.setWidth(10)),
                            UIText("0978675645", size: DimensManager.dimens.setSp(16))
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.mail_outlined, size: DimensManager.dimens.setSp(16)),
                            SizedBox(width: DimensManager.dimens.setWidth(10)),
                            UIText("vy@gmail.com", size: DimensManager.dimens.setSp(16))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: DimensManager.dimens.setHeight(10)),
              Container(
                height: DimensManager.dimens.setHeight(50),
                padding: EdgeInsets.symmetric(
                    vertical: DimensManager.dimens.setHeight(10),
                    horizontal: DimensManager.dimens.setWidth(10)
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(10)),
                    color: UIColors.white
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const UIText(UIStrings.address),
                    const Spacer(),
                    const UIText("3"),
                    Icon(
                      Icons.keyboard_arrow_right_rounded,
                      size: DimensManager.dimens.setSp(24),
                      color: UIColors.text,
                    )
                  ],
                )
              ),
              SizedBox(height: DimensManager.dimens.setHeight(30)),
              UITilte(UIStrings.order, color: UIColors.primary, fontWeight: FontWeight.bold),
              SizedBox(height: DimensManager.dimens.setHeight(30)),
              order == true ?
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(20)),
                      color: UIColors.white,
                    border: Border.all(color: UIColors.border),
                    boxShadow: [
                      BoxShadow(color: UIColors.border, blurRadius: 7, offset: const Offset(2,2))
                    ]
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          height: DimensManager.dimens.setHeight(150),
                          padding: EdgeInsets.symmetric(
                            horizontal: DimensManager.dimens.setWidth(20),
                            vertical: DimensManager.dimens.setHeight(30),
                          ),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: UIColors.border, width: 1)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const UIText("Order #100001", color: UIColors.black),
                                  UIText("11-April-2023, 3:00 PM", size: DimensManager.dimens.setSp(14)),
                                  UIText("Pending payment", color: UIColors.primary)
                                ],
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(10)),
                                child:  Image.network("https://image.istarbucks.co.kr/upload/store/skuimg/2021/02/[9200000001636]_20210225093600536.jpg",
                                    width: DimensManager.dimens.setWidth(80),
                                    height: DimensManager.dimens.setHeight(80)),
                              ),
                            ],
                          )
                        );
                      }
                  ),
                ),
              )
                  :Container(
                  height: DimensManager.dimens.setHeight(300),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(20)),
                      color: UIColors.white
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageIcon(
                          const AssetImage(AssetIcons.iconCartEmpty),
                          color: UIColors.primary,
                          size: DimensManager.dimens.setSp(100)
                      ),
                      const UIText(UIStrings.orderEmpty)
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
