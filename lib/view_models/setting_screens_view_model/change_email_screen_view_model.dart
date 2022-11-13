import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app2/repositories/user_repositories/abstract_user_repo.dart';
import '../../constant.dart';
import '../user_view_model.dart';

class ChangeEmailScreenViewModel extends ChangeNotifier{
  TextDirection emailTextDirection = TextDirection.rtl;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  bool spinner = false;

  emailOnChangeFun(BuildContext context, val) {
    RegExp exp = RegExp("[a-zA-Z]");
    if (val != null) {
      if (val.isNotEmpty) {
        if(val[val.length - 1] == " "){
          if (exp.hasMatch(val[val.length - 2])) {
            emailTextDirection = TextDirection.ltr;
          } else {
            emailTextDirection = TextDirection.rtl;
          }
        }else{
          if (exp.hasMatch(val[val.length - 1])) {
            emailTextDirection = TextDirection.ltr;
          } else {
            emailTextDirection = TextDirection.rtl;
          }
        }
      }
    }
    notifyListeners();
  }
  updateEmailFun({UserRepository? userRepository, UserViewModel? userViewModel})async{
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
        await userRepository!.updateEmail(userViewModel: userViewModel!, newEmail: emailController.text).then((value) => {
          emailController.clear(),
        });
        spinner = false;
        notifyListeners();
      }
    }
  }
}