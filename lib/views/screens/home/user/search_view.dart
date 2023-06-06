import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/viewmodel/search_view_model.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/widget/ui_text.dart';
import 'package:sahami_app/views/widget/ui_title.dart';
import '../../../../data/remote/entity/product_entity.dart';
import '../../../constants/ui_color.dart';
import '../../../constants/ui_strings.dart';
import 'package:intl/intl.dart' as intl;

class SearchView extends StatefulWidget {
  final String name;

  const SearchView({Key? key, required this.name}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final SearchViewModel _searchViewModel = SearchViewModel();

  @override
  void initState() {
    _searchViewModel.fetchCategory();
    _searchViewModel.filterNameProduct(widget.name);
    super.initState();
  }

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
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: DimensManager.dimens.setWidth(20),
                      vertical: DimensManager.dimens.setHeight(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      viewModel.categoryList.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Wrap(
                              spacing: 5,
                              runSpacing: 10,
                              children: viewModel.categoryList
                                  .map((eachCategory) => Container(
                                        padding: EdgeInsets.all(
                                            DimensManager.dimens.setWidth(10)),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                DimensManager.dimens
                                                    .setRadius(20)),
                                            color: UIColors.white),
                                        child:
                                            UIText(eachCategory.categoryName),
                                      ))
                                  .toList(),
                            ),
                      SizedBox(
                        height: DimensManager.dimens.setHeight(20),
                      ),
                      UIText(
                        "Mức giá",
                        color: UIColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      RangeSlider(
                        values: viewModel.selectedRange,
                        onChanged: (RangeValues newRating) {
                          viewModel.updateRating(newRating);
                        },
                        min: 0,
                        max: 100,
                        divisions: 4,
                        activeColor: UIColors.primary,
                        inactiveColor: UIColors.white,
                        labels: RangeLabels('${viewModel.selectedRange.start}',
                            '${viewModel.selectedRange.end}'),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: viewModel.resultList.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: DimensManager.dimens.setWidth(20)),
                          child: GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: viewModel.resultList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20.0,
                                mainAxisSpacing: 20.0,
                                childAspectRatio: 4 / 5,
                              ),
                              itemBuilder: (context, index) =>
                                  _buildItem(viewModel.resultList, index)),
                        ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildItem(List<ProductEntity> list, int index) {
    final formatter = intl.NumberFormat.decimalPattern();
    return Stack(
      children: [
        Card(
          margin: EdgeInsets.only(
            left: DimensManager.dimens.setWidth(20),
            top: DimensManager.dimens.setHeight(30),
          ),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(DimensManager.dimens.setRadius(20)),
              side: BorderSide(color: UIColors.primary, width: 1)),
          child: Padding(
            padding: EdgeInsets.only(
              top: DimensManager.dimens.setHeight(60),
              left: DimensManager.dimens.setWidth(10),
              right: DimensManager.dimens.setWidth(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UITitle(
                  list[index].priceSale == 0.0
                      ? "${formatter.format(list[index].price)} VNĐ"
                      : "${formatter.format(list[index].priceSale)} VNĐ",
                  size: DimensManager.dimens.setSp(18),
                  color: UIColors.textDart,
                ),
                SizedBox(
                  height: DimensManager.dimens.setHeight(5),
                ),
                UIText(
                  list[index].productName,
                  size: DimensManager.dimens.setSp(16),
                ),
                SizedBox(
                  height: DimensManager.dimens.setHeight(5),
                ),
                UIText(
                  list[index].description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  size: DimensManager.dimens.setSp(14),
                ),
                SizedBox(
                  height: DimensManager.dimens.setHeight(5),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          child: CircleAvatar(
            radius: 40,
            backgroundColor: null,
            backgroundImage: NetworkImage(list[index].image),
          ),
        )
      ],
    );
  }
}
