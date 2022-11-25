import 'package:flutter/src/widgets/framework.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/models/product_model.dart';
import 'package:store_app2/repositories/product_repositories/abstract_product_repo.dart';

import '../../view_models/product_view_model.dart';

class ProductAPIRepo extends ProductRepository {
  //Used for change Image Assets from network image to locale image
  @override
  DataConnectionEnum? get dataConnectionEnum => DataConnectionEnum.interNetData;

  @override
  Future<List<ProductModel>> getProductList() async {
    //for testing dependency injection
    return [
      ProductModel(
        id: 1,
        price: 200,
        title: "Camera",
        subTitle: "camera with high sensitivety",
        description: "sdmsdsdsd",
        image: "https://freepngimg.com/thumb/camera/24673-5-photo-camera-thumb.png",
      ),
    ];
  }

  @override
  Future<void> addProductToFavorites(ProductViewModel productViewModel) {
    // TODO: implement addProductToFavorites
    throw UnimplementedError();
  }

  @override
  Future<List<ProductViewModel>> getProductToFavorites() {
    // TODO: implement getProductToFavorites
    throw UnimplementedError();
  }

  @override
  Future<void> addProductToFavorite({required BuildContext context, ProductViewModel? productViewModel}) {
    // TODO: implement favoriteIcon
    throw UnimplementedError();
  }

  @override
  Future<List<ProductViewModel>> getFavoriteList({required BuildContext context}) {
    // TODO: implement getFavoriteList
    throw UnimplementedError();
  }

  @override
  Future<void> removeProductFromFavoriteList({required BuildContext context, required ProductViewModel productViewModel}) {
    // TODO: implement removeProductFromFavoriteList
    throw UnimplementedError();
  }

  @override
  Future<void> addProductToCart({required BuildContext context, required ProductViewModel productViewModel}) {
    // TODO: implement addProductToCart
    throw UnimplementedError();
  }

  @override
  Future<void> removeProductFromCartList({required BuildContext context, required ProductViewModel productViewModel}) {
    // TODO: implement removeProductFromCart
    throw UnimplementedError();
  }

  @override
  void removeFavoriteFromHomeList(context, {required ProductViewModel productViewModel}) {
    // TODO: implement unFavoriteFunction
  }

  @override
  void removeAddedProductFromHomeList(context, {required ProductViewModel productViewModel}) {
    // TODO: implement removeAddedProductFromHomeList
  }
}
