import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/viewmodel/search_view_model.dart';
import 'package:sahami_app/views/assets/asset_images.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/widget/ui_icon_button.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import 'package:sahami_app/views/widget/ui_title.dart';

import '../../../constants/ui_color.dart';
import '../../../constants/ui_strings.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final SearchViewModel _searchViewModel = SearchViewModel();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => _searchViewModel)],
      child: Scaffold(
        backgroundColor: UIColors.background,
        body: Consumer<SearchViewModel>(
          builder: (_, viewModel, __) {
            return Column(
              children: [
                SizedBox(
                  height: DimensManager.dimens.setHeight(20),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        DimensManager.dimens.setRadius(20)),
                    color: UIColors.white,
                    border: Border.all(color: UIColors.backgroundInput),
                    boxShadow: [
                      BoxShadow(
                          color: UIColors.border,
                          blurRadius: 7,
                          offset: const Offset(2, 2))
                    ],
                  ),
                  margin: EdgeInsets.only(
                      top: DimensManager.dimens.setWidth(60),
                      left: DimensManager.dimens.setWidth(20),
                      right: DimensManager.dimens.setWidth(20)),
                  child: TextFormField(
                    controller: viewModel.controller,
                    focusNode: viewModel.focusNode,
                    decoration: InputDecoration(
                      labelText: UIStrings.search,
                      prefixIcon: Icon(Icons.search, color: UIColors.primary),
                      border: InputBorder.none,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: DimensManager.dimens.setWidth(20)),
                    child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20.0,
                          mainAxisSpacing: 20.0,
                          childAspectRatio: 2/3,
                        ),
                        itemBuilder: (context, index) => _buildItem()),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildItem() {
    return Stack(
      children: [
        Card(
          margin: const EdgeInsets.only(left: 20, top: 20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DimensManager.dimens.setRadius(20)),
              side: BorderSide(
                  color: UIColors.primary,
                  width: 1
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UITitle("23,000 VNĐ", size: DimensManager.dimens.setSp(18), color: UIColors.textDart,),
              SizedBox(height: DimensManager.dimens.setHeight(5),),
              UIText("Sparkling Citrus Espresso", size: DimensManager.dimens.setSp(16),),
              SizedBox(height: DimensManager.dimens.setHeight(5),),
              UIText(
                "Refreshing lemon and ginger ale are added to reserve espresso, a coffee drink that provides a refreshing feeling and full of citrus flavor",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                size: DimensManager.dimens.setSp(14),
              ),
              SizedBox(height: DimensManager.dimens.setHeight(5),),
            ],
          ),
        ),
        const Positioned(
          left: 0,
          top: 0,
          child: CircleAvatar(
            radius: 40,
            backgroundColor: null,
            backgroundImage: AssetImage(AssetImages.product1),
          ),
        )
      ],
    );
  }
}


