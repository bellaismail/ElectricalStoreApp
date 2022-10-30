import 'package:flutter/cupertino.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/models/product_model.dart';
import 'package:store_app2/repositories/product_repositories/abstract_product_repo.dart';
import 'package:store_app2/view_models/product_view_model.dart';
import 'package:flutter/material.dart';

class HomeBodyViewModel with ChangeNotifier{
  HomeBodyViewModel({this.repository});
  ProductRepository? repository;
  List<ProductViewModel> productList = [];

  Future<List<ProductViewModel>> getAllProductList() async {
    List<ProductModel> productModelList = await repository!.getProductList();
    productList = productModelList
        .map((productModel) => ProductViewModel(productModel: productModel))
        .toList();
    return productList;
  }
  DataConnectionEnum? getDataConnectionEnum(){
    return repository!.dataConnectionEnum;
  }

  Future<void> favoriteFunction({required BuildContext context, ProductViewModel? productViewModel, ProductRepository? productRepository}) async{
    if(!productViewModel!.favorite!){
      productViewModel.setFavorite = true;
      await productRepository!.favoriteIcon(context: context, productViewModel: productViewModel);
    }else{
      productViewModel.setFavorite = false;
      await productRepository!.removeProductFromFavoriteList(context: context, productViewModel: productViewModel);
    }
    notifyListeners();
  }

  Future<void> addProductToCartFun({required BuildContext context, required ProductViewModel productViewModel, ProductRepository? productRepository}) async{
    await productRepository!.addProductToCart(context: context, productViewModel: productViewModel);
  }

}
