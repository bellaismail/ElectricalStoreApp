import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/repositories/product_repositories/abstract_product_repo.dart';
import 'package:store_app2/view_models/home_body_view_model.dart';
import 'package:store_app2/view_models/product_view_model.dart';

class FavoriteScreenViewModel with ChangeNotifier {
  final String appBarString = "ألمفضله لديك";
  List<ProductViewModel> favoriteList = [];

  Future<List<ProductViewModel>> getFavoriteList(
      {required BuildContext context,
      ProductRepository? productRepository}) async {
    return productRepository!.getFavoriteList(context: context);
  }

  Future<void> removeFromFavorite({
    required BuildContext context,
    required ProductViewModel productViewModel,
    ProductRepository? repo,
  }) async {
    var provider = Provider.of<HomeBodyViewModel>(context, listen: false);
    await repo!
        .removeProductFromFavoriteList(
            context: context, productViewModel: productViewModel);

    /*
    * must add function that change favorite icon on home_body_widget to un favorite icon
    * */

    notifyListeners();
  }

}
