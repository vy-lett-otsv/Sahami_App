import 'package:flutter/material.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/widget/ui_textinput_icon.dart';

import '../../../services/navigation_service.dart';
class ProductHomeView extends StatefulWidget {
  const ProductHomeView({Key? key}) : super(key: key);

  @override
  State<ProductHomeView> createState() => _ProductHomeViewState();
}

class _ProductHomeViewState extends State<ProductHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Product"),
        backgroundColor: UIColors.primary,
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
             NavigationServices.instance.navigationToProductCreateScreen(context);
            },
              child: const Icon(Icons.add)
          ),
          const SizedBox(width: 20)
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
                        labelText: "Search...",
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
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child:  Image.network("https://image.istarbucks.co.kr/upload/store/skuimg/2022/09/[9200000004294]_20220906081219976.jpg", width: 80, height: 80,),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Blonde Vanilla Latte"),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1,
                                        color: UIColors.primary
                                    )
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5
                                ),
                                child: const Text("Hot Coffee"),
                              )
                            ],
                          )
                        ],
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


