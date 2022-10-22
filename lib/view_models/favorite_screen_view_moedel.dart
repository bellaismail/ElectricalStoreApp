

import 'package:flutter/cupertino.dart';
import 'package:store_app2/repositories/product_repositories/abstract_product_repo.dart';
import 'package:store_app2/view_models/product_view_model.dart';

class FavoriteScreenViewModel extends ChangeNotifier{

  String? appBarTitle = "your favorite";
  List <ProductViewModel> favoriteList = [];

  Future<void> addProductToFavorite({ProductViewModel? productViewModel})async{
    favoriteList.add(productViewModel!);
    notifyListeners();
  }

  Future<List<ProductViewModel>> getProductsFromFavorites()async{
    return favoriteList;
  }
}