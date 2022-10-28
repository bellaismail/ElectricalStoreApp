import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/models/product_model.dart';
import 'package:store_app2/repositories/product_repositories/abstract_product_repo.dart';
import 'package:store_app2/view_models/product_view_model.dart';

import '../../view_models/favorite_screen_view_model.dart';

class ProductTestRepo extends ProductRepository {
  //Used for change Image Assets from network image to locale image
  @override
  DataConnectionEnum? get dataConnectionEnum => DataConnectionEnum.localData;

  @override
  Future<List<ProductModel>> getProductList() async {
    return productList;
  }

  @override
  Future<void> favoriteIcon(
      {required BuildContext context,
      ProductViewModel? productViewModel}) async {
    bool founded = false;
    var provider = Provider.of<FavoriteScreenViewModel>(context, listen: false);
    loop:
    for (int x = 0; x < provider.favoriteList.length; x++) {
      if (provider.favoriteList[x].title == productViewModel!.title) {
        founded = true;
        break loop;
      } else {
        founded = false;
      }
    }
    if (!founded) {
      provider.favoriteList.add(productViewModel!);
    }
  }

  @override
  Future<List<ProductViewModel>> getFavoriteList(
      {required BuildContext context}) async {
    var provider = Provider.of<FavoriteScreenViewModel>(context, listen: false);
    return provider.favoriteList;
  }

  @override
  Future<void> removeProductFromFavoriteList({
    required BuildContext context,
    required ProductViewModel productViewModel,
  }) async {
    var provider = Provider.of<FavoriteScreenViewModel>(context, listen: false);
    provider.favoriteList.removeWhere((element) => element.id == productViewModel.id);
  }
}
