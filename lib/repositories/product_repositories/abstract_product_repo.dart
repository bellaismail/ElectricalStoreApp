import 'package:flutter/cupertino.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/view_models/product_view_model.dart';

import '../../models/product_model.dart';

abstract class ProductRepository{
  //Used for change Image Assets from network image to locale image
  DataConnectionEnum? dataConnectionEnum;
  Future<List<ProductModel>> getProductList();
  Future<void> addProductToFavorite({required BuildContext context, ProductViewModel productViewModel});
  // Future<List<ProductViewModel>> getFavoriteList({required BuildContext context});
  Future<void> removeProductFromFavoriteList({required BuildContext context, required ProductViewModel productViewModel});
  Future<void> addProductToCart({ required BuildContext context,required ProductViewModel productViewModel});
  Future<void> removeProductFromCartList({required BuildContext context, required ProductViewModel productViewModel});
  void removeFavoriteFromHomeList(context,{required ProductViewModel productViewModel});
  void removeAddedProductFromHomeList(context,{required ProductViewModel productViewModel});
}