import 'package:store_app2/constant.dart';

import '../../models/product_model.dart';

abstract class ProductRepository{
  DataConnectionEnum? dataConnectionEnum;
  Future<List<ProductModel>> getProductList();
}