import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import 'package:sahami_app/views/widget/ui_button.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import 'package:sahami_app/views/widget/ui_textinput.dart';
import 'package:sahami_app/views/widget/ui_title.dart';
class ManageCreateCategoryView extends StatefulWidget {
  const ManageCreateCategoryView({Key? key}) : super(key: key);

  @override
  State<ManageCreateCategoryView> createState() => _ManageCreateCategoryViewState();
}

class _ManageCreateCategoryViewState extends State<ManageCreateCategoryView> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    DimensManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: UITilte(UIStrings.manageCategory, color: UIColors.white)),
        backgroundColor: UIColors.primary,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: DimensManager.dimens.setWidth(20)),
          child: Column(
            children: [
                SizedBox(height: DimensManager.dimens.setHeight(20)),
                Row(
                  children: [
                    Expanded(child: UITextInput(text: "Add new category", controller: controller)),
                    SizedBox(width: DimensManager.dimens.setWidth(10)),
                    UIButton(
                        text: "Add",
                        size: 18,
                        onPress: () {
                          final name = controller.text;
                          createCategory(name: name);
                        },
                    )
                  ],
                ),
              SizedBox(height: DimensManager.dimens.setHeight(20)),
              SingleChildScrollView(
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: DimensManager.dimens.setHeight(10),
                          vertical: DimensManager.dimens.setWidth(25)
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: UIColors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                UIText("1", size: 18,),
                                SizedBox(width: DimensManager.dimens.setWidth(20)),
                                UITilte("Cold Brew Coffee", size: 18, color: UIColors.primary),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {

                                  },
                                  child: Icon(Icons.edit, color: UIColors.star,),
                                ),
                                SizedBox(width: DimensManager.dimens.setWidth(20)),
                                GestureDetector(
                                  onTap: () {

                                  },
                                  child: Icon(Icons.delete, color: UIColors.lightRed,),
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
          ),
        ),
      ),
    );
  }
  Future createCategory({required String name}) async {
    final docCategory = FirebaseFirestore.instance.collection('category');
  }
}

