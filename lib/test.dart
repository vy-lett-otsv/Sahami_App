import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sahami_app/data/fake_data.dart';
import 'package:sahami_app/enums/fonts.dart';
import 'package:sahami_app/views/assets/asset_icons.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_button_statistics.dart';
import 'package:sahami_app/views/widget/ui_card_statistics.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import 'package:sahami_app/views/widget/ui_title.dart';


class StatisticsView extends StatefulWidget {
  const StatisticsView({Key? key}) : super(key: key);

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  int touchedIndex = -1;
  String dropdownValue = FakeData().listOrder.first;

  int touchIndex = 0;
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
                  const SizedBox(height: 20),
                  Card(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const UITilte("Order"),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: UIColors.primarySecond,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DropdownButton(
                                  items: FakeData().listOrder.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value, style: const TextStyle(color: UIColors.white)),
                                    );
                                  }).toList(),
                                  value: dropdownValue,
                                  icon: const Icon(Icons.keyboard_arrow_down, color: UIColors.white),
                                  dropdownColor: UIColors.primarySecond,
                                  onChanged: (String? value) {
                                    setState(() {
                                      dropdownValue = value!;
                                    });
                                  }
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 150,
                          color: Colors.teal,
                          child: PieChart(
                              PieChartData(
                                  sections: FakeData().getSections(touchedIndex),
                                  sectionsSpace: 0
                              )
                          ),
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 3,
                              child: Container(
                                color: Colors.yellow,
                                child: Text("Hi"),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                color: Colors.orange,
                                child: Text("Hi"),
                              ),
                            )
                          ],
                        )
                        // Row(
                        //   // mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     SizedBox(
                        //       height: 300,
                        //       child: PieChart(
                        //           PieChartData(
                        //               sections: FakeData().getSections(touchedIndex),
                        //               sectionsSpace: 0
                        //           )
                        //       ),
                        //     ),
                        //     Indicator()
                        //   ],
                        // )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}
