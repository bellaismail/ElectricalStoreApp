import '../models/product_model.dart';

abstract class Repository{
  Future<List<ProductModel>> getProductList();
}