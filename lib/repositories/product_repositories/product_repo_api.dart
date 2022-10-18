import 'package:store_app2/constant.dart';
import 'package:store_app2/models/product_model.dart';
import 'package:store_app2/repositories/product_repositories/abstract_product_repo.dart';

class ProductAPIRepo extends ProductRepository {
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
}
