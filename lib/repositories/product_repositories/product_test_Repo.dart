import 'package:store_app2/constant.dart';
import 'package:store_app2/models/product_model.dart';
import 'package:store_app2/repositories/product_repositories/abstract_product_repo.dart';

class ProductTestRepo extends ProductRepository{
  @override
  DataConnectionEnum? get dataConnectionEnum => DataConnectionEnum.localData;

  @override
  Future<List<ProductModel>> getProductList() async{
    return productList;
  }
}