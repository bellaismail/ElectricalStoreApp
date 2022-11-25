import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/models/product_model.dart';
import 'package:store_app2/repositories/product_repositories/abstract_product_repo.dart';
import 'package:store_app2/view_models/cart_screen_view_model.dart';
import 'package:store_app2/view_models/home_body_view_model.dart';
import 'package:store_app2/view_models/product_view_model.dart';
import 'package:store_app2/widgets/home_widgets/product_card_widget.dart';

import '../../core/local_data_base/local_database_sqlflite.dart';
import '../../view_models/favorite_screen_view_model.dart';
import '../user_repositories/abstract_user_repo.dart';
import '../user_repositories/user_repo_firebase.dart';

class ProductTestRepo extends ProductRepository {
  //Used for change Image Assets from network image to locale image
  @override
  DataConnectionEnum? get dataConnectionEnum => DataConnectionEnum.localData;

  @override
  Future<List<ProductModel>> getProductList() async {
    return productList;
  }
  /////////////////////////////////////////////////////////////////////////////
  @override
  Future<void> addProductToFavorite({required BuildContext context, ProductViewModel? productViewModel}) async {
    SQLDatabase sql = SQLDatabase();
    UserRepository userRepository = UserRepoFirebase();
    String sqlCommand =
        'INSERT INTO favorite(userId, productId, price, title, subTitle, description, image) VALUES("${userRepository.getCurrentUserId()}", ${productViewModel!.id}, ${productViewModel.price}, "${productViewModel.title}", "${productViewModel.subTitle}", "${productViewModel.description}", "${productViewModel.image}")';
    await sql.insertData(sqlCommand);
    Fluttertoast.showToast(
      msg: "قمت باضافه منتج الي المفضله",
      gravity: ToastGravity.BOTTOM,
      textColor: kBackgroundColor,
      backgroundColor: kPrimaryColor,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
  @override
  Future<void> removeProductFromFavoriteList({required BuildContext context, required ProductViewModel productViewModel}) async {
    var provider = Provider.of<FavoriteScreenViewModel>(context, listen: false);
    SQLDatabase sql = SQLDatabase();
    UserRepository userRepository = UserRepoFirebase();
    provider.favoriteList.removeWhere((element) => element.id == productViewModel.id);
    await sql.deleteData('DELETE FROM favorite WHERE userId = "${userRepository.getCurrentUserId()}" AND productId = ${productViewModel.id}');
    Fluttertoast.showToast(
      msg: "قمت بحزف منتج من المفضله",
      gravity: ToastGravity.BOTTOM,
      textColor: kBackgroundColor,
      backgroundColor: Colors.redAccent,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
  @override
  void removeFavoriteFromHomeList(context, {required ProductViewModel productViewModel,})async{
    UserRepository userRepository = UserRepoFirebase();
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setBool("${userRepository.getCurrentUserId()}${productViewModel.id}favorite", false);
  }
  /////////////////////////////////////////////////////////////////////////////
  @override
  Future<void> addProductToCart({required BuildContext context, required ProductViewModel productViewModel}) async {
    SQLDatabase sql = SQLDatabase();
    UserRepository userRepository = UserRepoFirebase();
    String sqlCommand =
        'INSERT INTO "cart"(userId, productId, price, title, subTitle, description, image) VALUES("${userRepository.getCurrentUserId()}", ${productViewModel.id}, ${productViewModel.price}, "${productViewModel.title}", "${productViewModel.subTitle}", "${productViewModel.description}", "${productViewModel.image}")';
    await sql.insertData(sqlCommand);
    Fluttertoast.showToast(
      msg: "قمت باضافه منتج الي العربه",
      backgroundColor: kPrimaryColor,
      textColor: kBackgroundColor,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
  @override
  Future<void> removeProductFromCartList({required BuildContext context, required ProductViewModel productViewModel}) async{
    var provider = Provider.of<CartScreenViewModel>(context, listen: false);
    SQLDatabase sql = SQLDatabase();
    UserRepository userRepository = UserRepoFirebase();
    provider.cartList.removeWhere((element) => element.id == productViewModel.id);
    await sql.deleteData('DELETE FROM "cart" WHERE userId = "${userRepository.getCurrentUserId()}" AND productId = ${productViewModel.id}');
    Fluttertoast.showToast(
      msg: "قمت بحزف منتج من العربه",
      gravity: ToastGravity.BOTTOM,
      textColor: kBackgroundColor,
      backgroundColor: Colors.redAccent,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
  @override
  void removeAddedProductFromHomeList(context, {required ProductViewModel productViewModel}) async{
    UserRepository userRepository = UserRepoFirebase();
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setBool("${userRepository.getCurrentUserId()}${productViewModel.id}cart", false);
  }

}
