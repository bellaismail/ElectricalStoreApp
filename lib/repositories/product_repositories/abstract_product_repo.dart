import 'package:store_app2/constant.dart';
import 'package:store_app2/view_models/product_view_model.dart';

import '../../models/product_model.dart';

abstract class ProductRepository{
  //Used for change Image Assets from network image to locale image
  DataConnectionEnum? dataConnectionEnum;
  Future<List<ProductModel>> getProductList();

  Future<void> addProductToFavorites(ProductViewModel productViewModel);
  Future<List<ProductViewModel>> getProductToFavorites();
}