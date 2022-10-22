
import 'package:store_app2/constant.dart';
import 'package:store_app2/models/product_model.dart';
import 'package:store_app2/repositories/product_repositories/abstract_product_repo.dart';
import 'package:store_app2/view_models/favorite_screen_view_moedel.dart';
import '../../view_models/product_view_model.dart';

class ProductTestRepo extends ProductRepository{

  //Used for change Image Assets from network image to locale image
  @override
  DataConnectionEnum? get dataConnectionEnum => DataConnectionEnum.localData;

  @override
  Future<List<ProductModel>> getProductList() async{
    return productList;
  }

  @override
  Future<void> addProductToFavorites(ProductViewModel productViewModel) async{
    // Using this function when i add favorite Product to data base

    print("*************Adding to List*******************");
    FavoriteScreenViewModel favoriteScreenViewModel = FavoriteScreenViewModel();
    favoriteScreenViewModel.favoriteList.add(productViewModel);
  }

  @override
  Future<List<ProductViewModel>> getProductToFavorites() async{
    print("*************getting to List*******************");
    FavoriteScreenViewModel favoriteScreenViewModel = FavoriteScreenViewModel();
    return favoriteScreenViewModel.favoriteList;
  }
}