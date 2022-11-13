import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app2/repositories/user_repositories/abstract_user_repo.dart';
import 'package:store_app2/view_models/user_view_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../constant.dart';

class ChangePasswordScreenViewModel extends ChangeNotifier{

  TextDirection passTextDirection = TextDirection.rtl;
  TextDirection confirmTextDirection = TextDirection.rtl;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  IconData confirmIcon = Icons.visibility_off_rounded;
  IconData passwordIcon = Icons.visibility_off_rounded;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  bool spinner = false;

  changeConfirmIcon() {
    if (confirmIcon == Icons.visibility_off_rounded) {
      confirmIcon = Icons.visibility;
    } else {
      confirmIcon = Icons.visibility_off_rounded;
    }
    notifyListeners();
  }
  changePasswordIcon() {
    if (passwordIcon == Icons.visibility_off_rounded) {
      passwordIcon = Icons.visibility;
    } else {
      passwordIcon = Icons.visibility_off_rounded;
    }
    notifyListeners();
  }
  passwordOnChangeFun(BuildContext context, val) {
    RegExp exp = RegExp("[a-zA-Z]");
    if (val != null) {
      if (val.isNotEmpty) {
        if(val[val.length - 1] == " "){
          if (exp.hasMatch(val[val.length - 2])) {
            passTextDirection = TextDirection.ltr;
          } else {
            passTextDirection = TextDirection.rtl;
          }
        }else{
          if (exp.hasMatch(val[val.length - 1])) {
            passTextDirection = TextDirection.ltr;
          } else {
            passTextDirection = TextDirection.rtl;
          }
        }
      }
    }
    notifyListeners();
  }
  confirmOnChangeFun(BuildContext context, val){
    RegExp exp = RegExp("[a-zA-Z]");
    if (val != null) {
      if (val.isNotEmpty) {
        if(val[val.length - 1] == " "){
          if (exp.hasMatch(val[val.length - 2])) {
            confirmTextDirection = TextDirection.ltr;
          } else {
            confirmTextDirection = TextDirection.rtl;
          }
        }else{
          if (exp.hasMatch(val[val.length - 1])) {
            confirmTextDirection = TextDirection.ltr;
          } else {
            confirmTextDirection = TextDirection.rtl;
          }
        }
      }
    }
    notifyListeners();
  }
  Future<void> updatePassword({required UserRepository userRepository, required UserViewModel userViewModel})async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if(key.currentState!.validate()){
      if(connectivityResult != ConnectivityResult.mobile &&
          connectivityResult != ConnectivityResult.wifi){
        Get.snackbar(
          "مشكله في الانترنت",
          "تاكد من الاتصال بالانترنت",
          backgroundColor: Colors.redAccent,
          colorText: kBackgroundColor,
        );
      }else{
        spinner = true;
        await userRepository.updatePassword(userViewModel: userViewModel).then((value) => {
          passwordController.clear(),
          confirmController.clear(),
        });
        spinner = false;
        notifyListeners();
      }
    }
  }
}