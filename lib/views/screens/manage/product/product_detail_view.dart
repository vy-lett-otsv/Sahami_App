import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/data/remote/enitity/product_entity.dart';
import 'package:sahami_app/viewmodel/product_view_model.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_icon_button.dart';
import '../../../../enums/fonts.dart';
import '../../../constants/ui_color.dart';
import '../../../widget/ui_text.dart';
import '../../../widget/ui_title.dart';
import 'package:intl/intl.dart' as intl;

class ProductDetailView extends StatefulWidget {
  final ProductEntity productEntity;

  const ProductDetailView({Key? key, required this.productEntity})
      : super(key: key);

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView>
    with SingleTickerProviderStateMixin {
  double productImageSize = DimensManager.dimens.setHeight(400);
  final ProductViewModel _productViewModel = ProductViewModel();
  late TabController _tabController;

  static const List<Tab> productTabs = <Tab>[
    Tab(text: 'Mô tả'),
    Tab(text: 'Thông tin'),
    Tab(text: 'Bình luận'),
  ];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: productTabs.length);
    _tabController.addListener(() {
      _productViewModel.changeStaffTab(_tabController.index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = intl.NumberFormat.decimalPattern();
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => _productViewModel)],
      child: Consumer<ProductViewModel>(
        builder: (_, productViewModel, __) {
          return Scaffold(
            body: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    width: DimensManager.dimens.fullWidth,
                    height: productImageSize,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.productEntity.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: DimensManager.dimens.setHeight(50),
                  left: DimensManager.dimens.setWidth(20),
                  right: DimensManager.dimens.setWidth(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UIIconButton(
                        icon: Icons.arrow_back_ios,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const UIIconButton(icon: Icons.shopping_cart_outlined)
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: productImageSize - 50,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.only(top: DimensManager.dimens.setHeight(30)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                              DimensManager.dimens.setRadius(20)),
                          topLeft: Radius.circular(
                              DimensManager.dimens.setRadius(20)),
                        ),
                        color: UIColors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: DimensManager.dimens.setWidth(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UITitle(widget.productEntity.productName),
                              SizedBox(height: DimensManager.dimens.setHeight(10)),
                              Row(
                                children: [
                                  Wrap(
                                    children: List.generate(5, (index) {
                                      return Icon(
                                        Icons.star,
                                        color: UIColors.star,
                                        size: 15,
                                      );
                                    }),
                                  ),
                                  SizedBox(width: DimensManager.dimens.setWidth(20)),
                                  const UIText("5.0"),
                                  SizedBox(width: DimensManager.dimens.setWidth(20)),
                                  const UIText("38 Comment"),
                                ],
                              ),
                              SizedBox(height: DimensManager.dimens.setHeight(20)),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          DimensManager.dimens.setRadius(30)),
                                    ),
                                    border: Border.all(
                                        width: 1, color: UIColors.primarySecond),
                                    color: UIColors.white),
                                child: TabBar(
                                  controller: _tabController,
                                  labelColor: UIColors.white,
                                  unselectedLabelColor: UIColors.primarySecond,
                                  labelStyle: TextStyle(
                                    fontFamily: Fonts.Inter,
                                    fontWeight: FontWeight.w700,
                                    fontSize: DimensManager.dimens.setSp(13),
                                    letterSpacing: 1,
                                  ),
                                  indicatorWeight: 1.0,
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        DimensManager.dimens.setRadius(30)),
                                    color: UIColors.primarySecond,
                                  ),
                                  tabs: productTabs,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: DimensManager.dimens.setWidth(20),
                                      vertical: DimensManager.dimens.setWidth(30),
                                    ),
                                    child: UIText(
                                      widget.productEntity.description,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                              _buildNutritionInformation(),
                              ListView.builder(itemBuilder: (context, index) {
                                return Container(
                                  color: UIColors.background,
                                  margin: EdgeInsets.only(bottom: DimensManager.dimens.setHeight(20)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: DimensManager.dimens.setHeight(10),
                                    horizontal: DimensManager.dimens.setWidth(20)
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage("https://i.pinimg.com/564x/65/2a/fa/652afa0a7cf9bac3e8af32384e34068e.jpg",),
                                      ),
                                      SizedBox(width: DimensManager.dimens.setWidth(10),),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               const UIText("Nguyen Van A"),
                                               Wrap(
                                                 children: List.generate(5, (index) {
                                                   return Icon(
                                                     Icons.star,
                                                     color: UIColors.star,
                                                     size: 18,
                                                   );
                                                 }),
                                               ),
                                             ],
                                           ),
                                            SizedBox(height: DimensManager.dimens.setHeight(10),),
                                            UIText("16/03/2023", size: DimensManager.dimens.setSp(12),),
                                            SizedBox(height: DimensManager.dimens.setHeight(10),),
                                            const UIText("Rất ngon, hợp khẩu vị, dễ uống, không quá ngọt.........")
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                );
                              })
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: UIColors.backgroundBottom,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(DimensManager.dimens.setRadius(30)),
                  topRight: Radius.circular(DimensManager.dimens.setRadius(30)),
                ),
              ),
              height: DimensManager.dimens.setHeight(100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UIIconButton(
                    icon: Icons.remove,
                    size: 36,
                    backgroundColor: UIColors.primary,
                    iconColor: UIColors.white,
                  ),
                  SizedBox(
                    width: DimensManager.dimens.setWidth(20),
                  ),
                  widget.productEntity.priceSale == 0
                      ? UIText(
                    "${formatter.format(widget.productEntity.price)} VNĐ X 0",
                    fontWeight: FontWeight.bold,
                  )
                      : UIText(
                    "${formatter.format(widget.productEntity.priceSale)} VNĐ X 0",
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    width: DimensManager.dimens.setWidth(20),
                  ),
                  UIIconButton(
                    icon: Icons.add,
                    size: 36,
                    backgroundColor: UIColors.primary,
                    iconColor: UIColors.white,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _buildNutritionInformation() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: DimensManager.dimens.setWidth(20),
          vertical: DimensManager.dimens.setHeight(30)),
      padding: EdgeInsets.symmetric(horizontal: DimensManager.dimens.setWidth(10),
      vertical: DimensManager.dimens.setHeight(20)),
      decoration: BoxDecoration(
          color: UIColors.white,
          borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(10)),
          border: Border.all(
              width: 2,
              color: UIColors.primarySecond),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
                offset: Offset(0, 5)),
            BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
                offset: Offset(5, 0)),
          ]),
      child: Column(
        children: [
          const UITitle(UIStrings.nutritionInformation),
          SizedBox(height: DimensManager.dimens.setHeight(30)),
          SizedBox(
            height: DimensManager.dimens.setHeight(80),
            child: Row(
              children: [
                _buildHeaderNutrition(
                    "${UIStrings.servingSize}(${UIStrings.kcal})",
                    "${UIStrings.saturatedFat}(${UIStrings.g})",
                    "${UIStrings.protein}(${UIStrings.g})",
                    15
                ),
                SizedBox(width: DimensManager.dimens.setWidth(10),),
                _buildNumberNutrition(
                    widget.productEntity.servingSize.toString(),
                    widget.productEntity.saturatedFat.toString(),
                    widget.productEntity.protein.toString(),
                    15
                ),
                VerticalDivider(
                  thickness: 1,
                  color: UIColors.backgroundBottom,
                  width: DimensManager.dimens.setWidth(30)
                ),
                _buildHeaderNutrition(
                    "${UIStrings.sodium}(${UIStrings.mg})",
                    "${UIStrings.sugars}(${UIStrings.g})",
                    "${UIStrings.caffeine}(${UIStrings.mg})",
                    15
                ),
                SizedBox(width: DimensManager.dimens.setWidth(10),),
                _buildNumberNutrition(
                    widget.productEntity.sodium.toString(),
                    widget.productEntity.sugars.toString(),
                    widget.productEntity.caffeine.toString(),
                    15
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeaderNutrition(String nutritionOne, String nutritionTwo, String nutritionThree, double size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIText(nutritionOne, size: DimensManager.dimens.setSp(size),),
        SizedBox(height: DimensManager.dimens.setHeight(10),),
        UIText(nutritionTwo, size: DimensManager.dimens.setSp(size),),
        SizedBox(height: DimensManager.dimens.setHeight(10),),
        UIText(nutritionThree, size: DimensManager.dimens.setSp(size),),
      ],
    );
  }

  Widget _buildNumberNutrition(String nutritionOne, String nutritionTwo, String nutritionThree, double size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        UIText(nutritionOne, size: DimensManager.dimens.setSp(size),),
        SizedBox(height: DimensManager.dimens.setHeight(10),),
        UIText(nutritionTwo, size: DimensManager.dimens.setSp(size),),
        SizedBox(height: DimensManager.dimens.setHeight(10),),
        UIText(nutritionThree, size: DimensManager.dimens.setSp(size),)
      ],
    );
  }
}
