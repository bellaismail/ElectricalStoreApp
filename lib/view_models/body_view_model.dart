import 'package:store_app2/constant.dart';
import 'package:store_app2/models/product_model.dart';
import 'package:store_app2/repositories/product_repositories/abstract_product_repo.dart';
import 'package:store_app2/view_models/product_view_model.dart';

class HomeBodyViewModel {
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
}
