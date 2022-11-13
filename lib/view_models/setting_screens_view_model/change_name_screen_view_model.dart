import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/repositories/user_repositories/abstract_user_repo.dart';
import '../user_view_model.dart';

class ChangeNameScreenViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextDirection nameTextDirection = TextDirection.ltr;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  Color? buttonColor = Colors.grey;
  bool spinner = false;

  changeButtonColor(String? val){
    val!.length >= 5 ? buttonColor = kTextColor: buttonColor = Colors.grey;
    notifyListeners();
  }
  nameOnChangeFun(BuildContext context, val) {
    RegExp exp = RegExp("[a-zA-Z]");
    if (val != null) {
      if (val.isNotEmpty) {
        if(val[val.length - 1] == " "){
          if (exp.hasMatch(val[val.length - 2])) {
            nameTextDirection = TextDirection.ltr;
          } else {
            nameTextDirection = TextDirection.rtl;
          }
        }else{
          if (exp.hasMatch(val[val.length - 1])) {
            nameTextDirection = TextDirection.ltr;
          } else {
            nameTextDirection = TextDirection.rtl;
          }
        }
      }
    }
    notifyListeners();
  }
  Future<void> updateNameFun({UserRepository? userRepository, UserViewModel? userViewModel, BuildContext? context}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (key.currentState!.validate()) {
      if (connectivityResult != ConnectivityResult.mobile &&
          connectivityResult != ConnectivityResult.wifi) {
        Get.snackbar(
          "مشكله في الانترنت",
          "تاكد من الاتصال بالانترنت",
          backgroundColor: Colors.redAccent,
          colorText: kBackgroundColor,
        );
      }else{
        spinner = true;
        await userRepository!.updateName(userViewModel: userViewModel!).then((value) => {
          nameController.clear(),
        });
        spinner = false;
        notifyListeners();
      }
    }
  }
}
