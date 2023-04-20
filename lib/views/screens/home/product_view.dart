import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sahami_app/views/constants/dimens_manager.dart';
import 'package:sahami_app/views/constants/ui_color.dart';
import 'package:sahami_app/views/constants/ui_strings.dart';
import '../../../enums/view_state.dart';
import '../../../viewmodel/product_view_model.dart';
import '../../widget/ui_text.dart';
import '../../widget/ui_title.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final ProductViewModel _productViewModel = ProductViewModel();

  @override
  void initState() {
    _productViewModel.fetchProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => _productViewModel)],
      child: Scaffold(
        backgroundColor: UIColors.background,
        appBar: AppBar(
          title: const Text(UIStrings.manageProduct),
          backgroundColor: UIColors.primary,
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
                onTap: () {
                  _productViewModel.goToScreenCreateProductView(context);
                },
                child: const Icon(Icons.add)),
            SizedBox(width: DimensManager.dimens.setWidth(20))
          ],
        ),
        body: SafeArea(child: Consumer<ProductViewModel>(
          builder: (_, product, __) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSearch(),
                Expanded(
                    child: product.viewState == ViewState.busy
                        ? const Center(child: CircularProgressIndicator())
                        : _buildListProduct(context, product))
              ],
            );
          },
        )),
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
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
            child: Icon(
              Icons.filter_list,
              color: UIColors.text,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListProduct(BuildContext context, ProductViewModel product) {
    return product.productList.isEmpty
        ? Container(
            margin: EdgeInsets.only(top: DimensManager.dimens.setHeight(20)),
            child: const UIText(UIStrings.isEmptyProduct))
        : ListView.builder(
            shrinkWrap: true,
            itemCount: product.productList.length,
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
                        onPressed: (context) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(DimensManager.dimens
                                              .setRadius(20))),
                                    ),
                                    title:
                                        const UITilte(UIStrings.titleConfirm),
                                    content:
                                        const UIText(UIStrings.confirmDelete),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: UIColors.white),
                                        child: UIText(UIStrings.cancel,
                                            color: UIColors.primary),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          _productViewModel.deleteProduct(
                                              product.productList[index]
                                                  .productId);
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: UIColors.primary),
                                        child: const UIText(UIStrings.ok,
                                            color: UIColors.white),
                                      )
                                    ],
                                  ));
                        }),
                    const Spacer(),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: DimensManager.dimens.setWidth(20),
                      vertical: DimensManager.dimens.setWidth(10)),
                  margin: EdgeInsets.symmetric(
                    vertical: DimensManager.dimens.setHeight(10),
                    horizontal: DimensManager.dimens.setWidth(20),
                  ),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(DimensManager.dimens.setSp(20)),
                      color: UIColors.white),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            DimensManager.dimens.setSp(20)),
                        child: Image.network(product.productList[index].image,
                            width: DimensManager.dimens.setWidth(80),
                            height: DimensManager.dimens.setHeight(80),
                            fit: BoxFit.cover),
                      ),
                      SizedBox(width: DimensManager.dimens.setWidth(20)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.productList[index].productName),
                          SizedBox(height: DimensManager.dimens.setHeight(10)),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    DimensManager.dimens.setSp(10)),
                                border: Border.all(
                                    width: 1, color: UIColors.primary)),
                            padding: EdgeInsets.symmetric(
                                horizontal: DimensManager.dimens.setWidth(10),
                                vertical: DimensManager.dimens.setHeight(5)),
                            child:
                                Text(product.productList[index].categoryName),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
  }
}
