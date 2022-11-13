import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/repositories/product_repositories/product_test_Repo.dart';
import 'package:store_app2/screens/details_screen.dart';
import 'package:store_app2/view_models/home_body_view_model.dart';
import 'package:store_app2/view_models/product_view_model.dart';

import '../home_widgets/product_card_widget.dart';

class HomeBodyWidget extends StatefulWidget with ChangeNotifier {
  @override
  State<HomeBodyWidget> createState() => _HomeBodyWidgetState();
}

class _HomeBodyWidgetState extends State<HomeBodyWidget> {
  HomeBodyViewModel homeBodyViewModel =
      HomeBodyViewModel(repository: ProductTestRepo());

  @override
  void initState() {
    Provider.of<HomeBodyViewModel>(context, listen: false).getAllProductList(repository: ProductTestRepo());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context);
    var provider = Provider.of<HomeBodyViewModel>(context);
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: kDefaultPadding / 2.0),
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 90.0,
                  ),
                  decoration: const BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kDefaultPadding),
                      topRight: Radius.circular(kDefaultPadding),
                    ),
                  ),
                ),
                provider.productList.isEmpty? const Center(child: CircularProgressIndicator(),):ListView.builder(
                  physics: null,
                  itemCount: provider.productList.length,
                  itemBuilder: (context, index) {
                    return ProductCardWidget(
                      itemIndex: index,
                      productModel: provider.productList[index],
                      onTapFun: () {
                        Get.to(
                          DetailsScreen(
                            productViewModel: provider.productList[index],
                            dataConnectionEnum:
                            homeBodyViewModel.getDataConnectionEnum(),
                          ),
                        );
                      },
                      dataConnectionEnum:
                      homeBodyViewModel.getDataConnectionEnum(),
                      favorite: provider.productList[index].favorite,
                      favoriteOnPressedFun: () {
                        provider.favoriteFunction(
                          context: context,
                          productViewModel: provider.productList[index],
                          productRepository: ProductTestRepo(),
                        );
                      },
                      addToCartOnPressedFun: () async {
                        await provider
                            .addProductToCartFun(
                          context: context,
                          productViewModel: provider.productList[index],
                          productRepository: ProductTestRepo(),
                        )
                            .then((value) => {
                          Fluttertoast.showToast(
                            msg: "قمت باضافه منتج جديد",
                            backgroundColor: kPrimaryColor,
                            textColor: kBackgroundColor,
                            gravity: ToastGravity.BOTTOM,
                            toastLength: Toast.LENGTH_SHORT,
                          ),
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
