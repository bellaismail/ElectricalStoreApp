import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/models/product_model.dart';
import 'package:store_app2/repositories/product_repositories/abstract_product_repo.dart';
import 'package:store_app2/view_models/cart_screen_view_model.dart';
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
      if (provider.favoriteList[x].id == productViewModel!.id) {
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

  @override
  Future<void> addProductToCart({required BuildContext context ,required ProductViewModel productViewModel}) async{
    var provider = Provider.of<CartScreenViewModel>(context, listen: false);
    bool founded = false;
    loop:
    for(int x = 0; x < provider.cartList.length; x++){
      if(provider.cartList[x].id == productViewModel.id){
        founded = true;
        break loop;
      }else{
        founded = false;
      }
    }
    if(!founded){
      provider.cartList.add(productViewModel);
    }
  }

  @override
  Future<void> removeProductFromCart({required BuildContext context, required ProductViewModel productViewModel}) async{
    var provider = Provider.of<CartScreenViewModel>(context, listen: false);
    try{
      provider.cartList.removeWhere((element) => element.id == productViewModel.id);
    }catch(e){
      throw Exception("=== something Error on removeProductFRomCartFun => $e ===");
    }
  }
}
