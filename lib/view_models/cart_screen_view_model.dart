import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/repositories/product_repositories/abstract_product_repo.dart';
import 'package:store_app2/view_models/home_body_view_model.dart';
import 'package:store_app2/view_models/product_view_model.dart';
import 'package:stripe_payment/stripe_payment.dart';

import '../core/local_data_base/local_database_sqlflite.dart';
import '../models/product_model.dart';
import '../repositories/user_repositories/abstract_user_repo.dart';
import '../repositories/user_repositories/user_repo_firebase.dart';

class CartScreenViewModel with ChangeNotifier {
  String title = "عربتك";
  List<ProductViewModel> cartList = [];
  bool confirmDelete = false;
  bool incrementOrDecrement = false;
  bool showIncrementAndDecrement = false;



  getCartList() async {
    SQLDatabase sql = SQLDatabase();
    UserRepository userRepository = UserRepoFirebase();
    var list = List.from(await sql.readData('SELECT * FROM "cart" WHERE userId = "${userRepository.getCurrentUserId()}"'));
    cartList = list
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
  incrementNumOfProduct({required ProductViewModel productViewModel}){
    productViewModel.incrementProductTotalNum();
    notifyListeners();
  }
  decrementNumOfProduct({required ProductViewModel productViewModel}){
    productViewModel.decrementProductTotalNum();
    notifyListeners();
  }

  Future<void> removeProductFromCart(
      {required ProductRepository productRepository,
      required BuildContext context,
      required ProductViewModel productViewModel}) async {
    var provider = Provider.of<HomeBodyViewModel>(context, listen: false);
    await productRepository.removeProductFromCartList(
      context: context,
      productViewModel: productViewModel,
    );
    provider.removeAddedFromHomeList(context,repository: productRepository, productViewModel: productViewModel);
    productViewModel.productTotalNumFun = 1;
    notifyListeners();
  }

  int getTotalPrice() {
    int totalPrice = 0;
    for (int x = 0; x < cartList.length; x++) {
      totalPrice = totalPrice + (cartList[x].price! * cartList[x].productTotalNum!);
    }
    return totalPrice;
  }

  confirmDeleteFun(){
    confirmDelete = true;
    notifyListeners();
  }
  rejectDeleteFun(){
    confirmDelete = false;
    notifyListeners();
  }

  DataConnectionEnum getDataConnectionEnum({required ProductRepository productRepository,}){
    return productRepository.dataConnectionEnum!;
  }

  checkOutFun() {
    StripePayment.paymentRequestWithNativePay(
            androidPayOptions: AndroidPayPaymentRequest(
              currencyCode: "EUR",
              totalPrice: getTotalPrice().toString(),
              lineItems: [
                LineItem(
                  totalPrice: "500",
                  description: "pants",
                  quantity: "very good",
                  unitPrice: "untilPrice",
                ),
              ]
            ),
            applePayOptions: ApplePayPaymentOptions(
              countryCode: 'DE',
              currencyCode: 'EUR',
              items: [
                ApplePayItem(
                  label: 'pants',
                  amount: '27',
                )
              ],
            ))
        .then((token) {
          Get.snackbar("تم", "tokenId: تم تأكيد الدفع", backgroundColor: Colors.green, colorText: kBackgroundColor);
    }).catchError((e) {
      Get.snackbar("خطأ", "لم تقم بالدفع", backgroundColor: Colors.orange, colorText: kBackgroundColor);
    });
  }
}
