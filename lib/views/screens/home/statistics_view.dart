import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sahami_app/views/assets/asset_icons.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_button_statistics.dart';
import 'package:sahami_app/views/widget/ui_card_statistics.dart';
import 'package:sahami_app/views/widget/ui_text.dart';

class StatisticsView extends StatefulWidget {
  const StatisticsView({Key? key}) : super(key: key);

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          color: UIColors.primarySecond,
          padding:
              const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    "https://image.istarbucks.co.kr/upload/store/skuimg/2022/09/[9200000004294]_20220906081219976.jpg"),
              ),
              const SizedBox(width: 10),
              Column(
                children: const [
                  UIText("Le Vy",
                      color: UIColors.white, fontWeight: FontWeight.bold),
                  SizedBox(height: 5),
                  UIText("Admin", color: UIColors.white, size: 14)
                ],
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    UIButtonStatistics(
                        title: UIStrings.addProduct,
                        image: AssetIcons.iconProductWhite),
                    UIButtonStatistics(
                        icon: Icons.article, title: UIStrings.addOrder),
                    UIButtonStatistics(
                        icon: Icons.person, title: UIStrings.addCustomer)
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.9,
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                children: const [
                  UICardStatistics(title: UIStrings.totalProduct, data: "10"),
                  UICardStatistics(
                      title: UIStrings.totalRevenue, data: "10.000K"),
                  UICardStatistics(title: UIStrings.totalCustomer, data: "50"),
                  UICardStatistics(title: UIStrings.totalOrder, data: "10.000"),
                ],
              ),
              Container(
                color: UIColors.white,
                child: AspectRatio(
                    aspectRatio: 1.3,
                    child: Row(
                      children: [
                        Expanded(
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: PieChart(
                                  PieChartData(
                                    pieTouchData: PieTouchData(
                                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                        setState(() {
                                          if (!event.isInterestedForInteractions ||
                                              pieTouchResponse == null ||
                                              pieTouchResponse.touchedSection == null) {
                                            touchedIndex = -1;
                                            return;
                                          }
                                          touchedIndex = pieTouchResponse
                                              .touchedSection!
                                              .touchedSectionIndex;
                                        }
                                        );
                                      },
                                    ),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 40,
                                    sections: showingSections(),
                                  ),
                                )
                            )
                        ),
                      ],
                    )
                ),
              )
            ],
          ),
        )
      ],
    )
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: UIColors.inputBackground,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: UIColors.text,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: UIColors.inputBackground,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: UIColors.text,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: UIColors.inputBackground,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: UIColors.text,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
