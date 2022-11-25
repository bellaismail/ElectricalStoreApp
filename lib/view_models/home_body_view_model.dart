import 'package:store_app2/constant.dart';
import 'package:store_app2/core/local_data_base/local_database_sqlflite.dart';
import 'package:store_app2/models/product_model.dart';
import 'package:store_app2/repositories/product_repositories/abstract_product_repo.dart';
import 'package:store_app2/view_models/product_view_model.dart';
import 'package:flutter/material.dart';

class HomeBodyViewModel with ChangeNotifier{
  HomeBodyViewModel({this.repository});
  ProductRepository? repository;
  List<ProductViewModel> productList = [];

  SQLDatabase sql = SQLDatabase();
  getAllProductList({required ProductRepository? repository}) async {
    List<ProductModel> productModelList = await repository!.getProductList();
    productList = productModelList
        .map((productModel) => ProductViewModel(productModel: productModel))
        .toList();
    notifyListeners();
  }
  DataConnectionEnum? getDataConnectionEnum(){
    return repository!.dataConnectionEnum;
  }
  Future<void> favoriteFunction({required BuildContext context, ProductViewModel? productViewModel, ProductRepository? productRepository, bool? favorite, userId}) async{
    if(!favorite!){
      await productRepository!.addProductToFavorite(context: context, productViewModel: productViewModel!);
    }else{
      await productRepository!.removeProductFromFavoriteList(context: context, productViewModel: productViewModel!);
    }
    notifyListeners();
  }
  removeFavoriteFromHomeList(context, {required ProductRepository repository, required ProductViewModel productViewModel}){
    repository.removeFavoriteFromHomeList(context, productViewModel: productViewModel);
    notifyListeners();
  }

  Future<void> addProductToCartFun({required BuildContext context, required ProductViewModel productViewModel, ProductRepository? productRepository, bool? isAddedToCart, userId}) async{
    if(!isAddedToCart!){
      await productRepository!.addProductToCart(context: context, productViewModel: productViewModel);
    }else{
      productRepository!.removeProductFromCartList(context: context, productViewModel: productViewModel);
    }
    notifyListeners();
  }
  removeAddedFromHomeList(context, {required ProductRepository repository, required ProductViewModel productViewModel}){
    repository.removeAddedProductFromHomeList(context, productViewModel: productViewModel);
    notifyListeners();
  }
}
