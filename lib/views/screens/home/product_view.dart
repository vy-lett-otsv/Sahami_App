import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.background,
      appBar: AppBar(
        title: const Text(UIStrings.manageProduct),
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
              Container(
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
                      child: Icon(Icons.filter_list, color: UIColors.text,),
                    )
                  ],
                ),
              ),
              Expanded(
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
                                child:  Image.network("https://image.istarbucks.co.kr/upload/store/skuimg/2022/09/[9200000004294]_20220906081219976.jpg",
                                  width: DimensManager.dimens.setWidth(80),
                                  height: DimensManager.dimens.setHeight(80),),
                              ),
                              SizedBox(width: DimensManager.dimens.setWidth(20)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Blonde Vanilla Latte"),
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
                                    child: const Text("Hot Coffee"),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }
                ),
              )
            ],
          )
      ),
    );
  }
}

