import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/services/navigation_service.dart';
import 'package:sahami_app/viewmodel/home_view_model.dart';
import 'package:sahami_app/viewmodel/product_view_model.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import 'package:sahami_app/views/widget/ui_title.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import '../../../utils/constants.dart';
import '../../constants/dimens_manager.dart';
import '../../constants/ui_color.dart';
import '../../widget/ui_text_price.dart';
import 'package:dots_indicator/dots_indicator.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel _homeViewModel = HomeViewModel();
  final ProductViewModel _productViewModel = ProductViewModel();

  @override
  void initState() {
    _homeViewModel.pageControllerView();
    _productViewModel.fetchProducts("product");
    _productViewModel.fetchProducts("feature");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _homeViewModel),
        ChangeNotifierProvider(create: (_) => _productViewModel)
      ],
      child: Scaffold(
        backgroundColor: UIColors.background,
        body: SafeArea(
          child: SingleChildScrollView(child: Consumer<HomeViewModel>(
            builder: (_, homeViewModel, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<HomeViewModel>(builder: (_, viewModel, __) {
                    return _buildHeader(viewModel, context);
                  },),
                  SizedBox(height: DimensManager.dimens.setHeight(20)),
                  Consumer<ProductViewModel>(
                    builder: (_, productViewModel, __) {
                      return productViewModel.featureProductList.isEmpty
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: DimensManager.dimens.setHeight(50)),
                              child: const Center(child: CircularProgressIndicator()),
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: DimensManager.dimens.setHeight(350),
                                  child: PageView.builder(
                                      controller: homeViewModel.pageController,
                                      itemCount: productViewModel.featureProductList.length,
                                      itemBuilder: (context, index) {
                                        homeViewModel.matrixSlide(index);
                                        return _buildPageItem(homeViewModel, productViewModel, index);
                                      }),
                                ),
                                SizedBox(height: DimensManager.dimens.setHeight(10)),
                                DotsIndicator(
                                  dotsCount: productViewModel.featureProductList.length,
                                  position: homeViewModel.currPageValue,
                                  decorator: DotsDecorator(
                                    activeColor: UIColors.primary,
                                    size: const Size.square(9.0),
                                    activeSize: const Size(18.0, 9.0),
                                    activeShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0)),
                                  ),
                                )
                              ],
                            );
                    },
                  ),
                  SizedBox(height: DimensManager.dimens.setHeight(10)),
                  Consumer<ProductViewModel>(
                    builder: (_, productViewModel, __) {
                      return _buildProduct(productViewModel);
                    },
                  )
                ],
              );
            },
          )),
        ),
      ),
    );
  }

  Widget _buildPageItem(HomeViewModel homeViewModel,
      ProductViewModel productViewModel, int index) {
    return Transform(
      transform: homeViewModel.matrix,
      child: GestureDetector(
        onTap: () {
          NavigationServices.instance.navigationToProductDetailScreen(
            context,
            arguments: {
              Constants.ENTITY:
              productViewModel.featureProductList.elementAt(index),
            },
          );
        },
        child: Stack(children: [
          Container(
            margin: EdgeInsets.only(
              bottom: DimensManager.dimens.setHeight(40),
              right: DimensManager.dimens.setHeight(10),
              left: DimensManager.dimens.setHeight(10),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: UIColors.primary,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      productViewModel.featureProductList[index].image),
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: DimensManager.dimens.setHeight(100),
              margin: EdgeInsets.only(
                  right: DimensManager.dimens.setWidth(40),
                  left: DimensManager.dimens.setWidth(40),
                  top: DimensManager.dimens.setHeight(30)),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(DimensManager.dimens.setRadius(20)),
                  color: UIColors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0, // độ tán của bóng
                        offset: Offset(0, 5) // (x, y) x y dời qua 5 px
                        ),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0))
                  ]),
              child: Container(
                  padding: EdgeInsets.only(
                    top: DimensManager.dimens.setHeight(15),
                    right: DimensManager.dimens.setWidth(15),
                    left: DimensManager.dimens.setWidth(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UITitle(
                          productViewModel.featureProductList[index].productName),
                      SizedBox(height: DimensManager.dimens.setHeight(10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                              SizedBox(width: DimensManager.dimens.setWidth(10)),
                              const UIText("5.0"),
                            ],
                          ),
                          const UIText("38 Comment"),
                        ],
                      )
                    ],
                  )),
            ),
          )
        ]),
      ),
    );
  }
}

Widget _buildHeader(HomeViewModel viewModel, BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: DimensManager.dimens.setWidth(20)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: DimensManager.dimens.setHeight(20)),
        UITitle(UIStrings.appName, size: 40, color: UIColors.primary),
        SizedBox(height: DimensManager.dimens.setHeight(20)),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(20)),
              color: UIColors.white,
              border: Border.all(color: UIColors.backgroundInput),
              boxShadow: [
                BoxShadow(
                    color: UIColors.border,
                    blurRadius: 7,
                    offset: const Offset(2, 2))
              ],
          ),
          padding: const EdgeInsets.only(left: 16, right: 4),
          child: TextFormField(
            controller: viewModel.controller,
            focusNode: viewModel.focusNode,
            decoration: InputDecoration(
                labelText: UIStrings.search,
                prefixIcon: Icon(Icons.search, color: UIColors.primary),
                border: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: EdgeInsets.zero,),
            onFieldSubmitted: (value) {
              viewModel.navigateSearchView(context);
            },
          ),
        )
      ],
    ),
  );
}

Widget _buildProduct(ProductViewModel productViewModel) {
  return StickyHeader(
    header: Container(
      height: DimensManager.dimens.setHeight(70),
      color: UIColors.background,
      padding:
          EdgeInsets.symmetric(horizontal: DimensManager.dimens.setWidth(16)),
      alignment: Alignment.centerLeft,
      child: const UITitle(UIStrings.product),
    ),
    content: Container(
      padding:
          EdgeInsets.symmetric(horizontal: DimensManager.dimens.setWidth(20)),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: productViewModel.productList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              NavigationServices.instance.navigationToProductDetailScreen(
                context,
                arguments: {
                  Constants.ENTITY:
                      productViewModel.productList.elementAt(index),
                },
              );
            },
            child: Container(
              padding:
                  EdgeInsets.only(bottom: DimensManager.dimens.setHeight(20)),
              child: Row(
                children: [
                  Container(
                    width: DimensManager.dimens.setWidth(100),
                    height: DimensManager.dimens.setHeight(100),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          DimensManager.dimens.setRadius(20)),
                      color: Colors.white38,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            productViewModel.productList[index].image),
                      ),
                    ),
                  ),
                  SizedBox(width: DimensManager.dimens.setWidth(20)),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UITitle(
                            productViewModel.productList[index].productName),
                        SizedBox(height: DimensManager.dimens.setHeight(10)),
                        UIText(
                            productViewModel.productList[index].categoryName),
                        SizedBox(height: DimensManager.dimens.setHeight(10)),
                        SizedBox(
                          width: DimensManager.dimens.setWidth(250),
                          child: productViewModel.productList[index].priceSale != 0 ?
                              UITextPrice(
                                  price: productViewModel.productList[index].price,
                                  priceSale: productViewModel.productList[index].priceSale,
                                  isPriceSale: true,
                                  end: true,
                                )
                              : UITextPrice(
                            price: productViewModel.productList[index].price
                          ),
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
    ),
  );
}
