import 'package:store_app2/models/product_model.dart';
import 'package:store_app2/repositories/abstract_repo.dart';

class TestRepo extends Repository{
  @override
  Future<List<ProductModel>> getProductList() async{
    return productList;
  }

}