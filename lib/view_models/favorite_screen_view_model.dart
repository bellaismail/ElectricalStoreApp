import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/core/local_data_base/local_database_sqlflite.dart';
import 'package:store_app2/models/product_model.dart';
import 'package:store_app2/repositories/product_repositories/abstract_product_repo.dart';
import 'package:store_app2/repositories/user_repositories/abstract_user_repo.dart';
import 'package:store_app2/repositories/user_repositories/user_repo_firebase.dart';
import 'package:store_app2/view_models/home_body_view_model.dart';
import 'package:store_app2/view_models/product_view_model.dart';

class FavoriteScreenViewModel with ChangeNotifier {
  final String appBarString = "ألمفضله لديك";
  List<ProductViewModel> favoriteList = [];
  bool confirmDelete = false;


  confirmDeleteFun(){
    confirmDelete = true;
    notifyListeners();
  }
  rejectDeleteFun(){
    confirmDelete = false;
    notifyListeners();
  }
  getFavoriteList() async {
    SQLDatabase sql = SQLDatabase();
    UserRepository userRepository = UserRepoFirebase();
    var list = List.from(await sql.readData('SELECT * FROM favorite WHERE userId = "${userRepository.getCurrentUserId()}"'));
    favoriteList = list
        .map((e) => ProductViewModel(
                productModel: ProductModel(
              id: e["productId"],
              image: e["image"],
              description: e["description"],
              price: e["price"],
              title: e["title"],
              subTitle: e["subTitle"],
            )))
        .toList();
    notifyListeners();
  }

  Future<void> removeFromFavorite({required BuildContext context, required ProductViewModel productViewModel, ProductRepository? repo,}) async {
    var provider = Provider.of<HomeBodyViewModel>(context, listen: false);
    await repo!.removeProductFromFavoriteList(context: context, productViewModel: productViewModel);
    provider.removeFavoriteFromHomeList(context, repository: repo, productViewModel: productViewModel);
    notifyListeners();
  }

}
