import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/repositories/product_repositories/abstract_product_repo.dart';
import 'package:store_app2/view_models/product_view_model.dart';
import 'package:flutter/material.dart';

class CartScreenViewModel with ChangeNotifier {
  String title = "عربتك";
  List<ProductViewModel> cartList = [];

  Future<void> removeProductFromCart({
    required ProductRepository productRepository,
    required BuildContext context,
    required ProductViewModel productViewModel,
  }) async {
    await productRepository.removeProductFromCart(
      context: context,
      productViewModel: productViewModel,
    ).then((value) => {
      Fluttertoast.showToast(
        msg: "قمت بحزف منتج",
        gravity: ToastGravity.BOTTOM,
        textColor: kBackgroundColor,
        backgroundColor: Colors.redAccent,
        toastLength: Toast.LENGTH_SHORT,
      ),
    });
    notifyListeners();
  }

  int getPrice() {
    int totalPrice = 0;
    for (int x = 0; x < cartList.length; x++) {
      totalPrice = totalPrice + cartList[x].price!;
    }
    return totalPrice;
  }

  DataConnectionEnum getDataConnectionEnum({required ProductRepository productRepository,}){
    return productRepository.dataConnectionEnum!;
  }
}
