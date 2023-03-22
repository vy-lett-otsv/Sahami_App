import 'package:flutter/material.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import 'package:sahami_app/views/widget/ui_title.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import '../../assets/asset_images.dart';
import '../../constants/dimens_manager.dart';
import '../../constants/ui_color.dart';
import '../../widget/ui_textinput.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final double _height = (Get.context!.height)/6.5;
  PageController pageController = PageController(viewportFraction: 0.9);//Phần nhỏ của khung nhìn mà mỗi trang sẽ chiếm.
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;

  @override
  void initState() {
    super.initState();
    DimensManager();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: DimensManager.dimens.setHeight(20)),
              _buildSlideProduct(pageController, _buildPageItem, _currPageValue),
              SizedBox(height: DimensManager.dimens.setHeight(20)),
              _buildProduct()
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildPageItem(int index) {

    Matrix4 matrix = Matrix4.identity();
    if(index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue-index)*(1-_scaleFactor);
      var curTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1,currScale, 1)..setTranslationRaw(0, curTrans, 0);
    } else if(index == _currPageValue.floor()+1) {
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var curTrans = _height*(1-currScale)/2; //220*(1-0.8)/2 = 220*0.2/2 = 220*1/10 = 22
      matrix = Matrix4.diagonal3Values(1,currScale, 1);
      matrix = Matrix4.diagonal3Values(1,currScale, 1)..setTranslationRaw(0, curTrans, 0);
    } else if(index == _currPageValue.floor()-1) {
      var currScale = 1 - (_currPageValue-index)*(1-_scaleFactor);
      var curTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1,currScale, 1);
      matrix = Matrix4.diagonal3Values(1,currScale, 1)..setTranslationRaw(0, curTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1,currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(
                  bottom: DimensManager.dimens.setHeight(40),
                  right: DimensManager.dimens.setHeight(10),
                  left: DimensManager.dimens.setHeight(10),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: UIColors.primary,
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(AssetImages.product1),
                  )
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: DimensManager.dimens.setHeight(100),
                margin: EdgeInsets.only(
                    right: DimensManager.dimens.setWidth(40),
                    left: DimensManager.dimens.setWidth(40),
                    top: DimensManager.dimens.setHeight(30)
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(20)),
                  color: UIColors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0, // độ tán của bóng
                        offset: Offset(0,5) // (x, y) x y dời qua 5 px
                    ),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5,0)
                    ),  BoxShadow(
                        color: Colors.white,
                        offset: Offset(5,0)
                    )
                  ]
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    top: DimensManager.dimens.setHeight(15),
                    right: DimensManager.dimens.setWidth(15),
                    left: DimensManager.dimens.setWidth(15),
                  ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const UITilte(UIStrings.product1),
                        SizedBox(height: DimensManager.dimens.setHeight(10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Wrap(
                                  children: List.generate(5, (index) { return Icon(Icons.star, color: UIColors.star, size: 15,);}),
                                ),
                                SizedBox(width: DimensManager.dimens.setWidth(10)),
                                UIText("5.0"),
                              ],
                            ),
                            UIText("38 Comment"),
                          ],
                        )
                      ],
                    )
                ),
              ),
            )
          ]
      ),
    );
  }
}

Widget _buildHeader() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: DimensManager.dimens.setWidth(20)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UITilte(UIStrings.appName, size: 40, color: UIColors.primary),
        SizedBox(height: DimensManager.dimens.setHeight(20)),
        const UITextInput(
          text: UIStrings.search,
          icon: Icons.search,
        ),
      ],
    ),
  );
}

Widget _buildSlideProduct(PageController pageController, Widget _buildPageItem(int position), double _currPageValue)   {
  return Column (
    children: [
      SizedBox(
        height: DimensManager.dimens.setHeight(320),
        child: PageView.builder(
            controller: pageController,
            itemCount: 5,
            itemBuilder: (context, position) {
              return _buildPageItem(position);
            }
        ),
      ),
      SizedBox(height: DimensManager.dimens.setHeight(10)),
      DotsIndicator(
        dotsCount: 5,
        position: _currPageValue,
        decorator: DotsDecorator(
          activeColor: UIColors.primary,
          size: const Size.square(9.0),
          activeSize: const Size(18.0, 9.0),
          activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      )
    ],
  );
}

Widget _buildProduct() {
  return StickyHeader(
      header: Container(
        height: 50.0,
        color: UIColors.background,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: const UITilte(UIStrings.product),
      ),
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: DimensManager.dimens.setWidth(20)),
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: DimensManager.dimens.setHeight(20)),
                      child: Row(
                        children: [
                          Container(
                            width: DimensManager.dimens.setWidth(100),
                            height: DimensManager.dimens.setHeight(100),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(20)),
                                color: Colors.white38,
                                image:  const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(AssetImages.product1)
                                )
                            ),
                          ),
                          SizedBox(width: DimensManager.dimens.setWidth(20)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const UITilte("Blonde Vanila Latte"),
                              SizedBox(height: DimensManager.dimens.setHeight(10)),
                              UIText("Hot Coffee"),
                              SizedBox(height: DimensManager.dimens.setHeight(10)),
                              const SizedBox(
                                width: 210,
                                child: UITilte("22,000 VNĐ",
                                    size: 18,
                                    textAlign: TextAlign.end,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
        ),
      )
  );
}