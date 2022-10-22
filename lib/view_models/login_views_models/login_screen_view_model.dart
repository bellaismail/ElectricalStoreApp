import 'package:flutter/material.dart';
import 'package:store_app2/models/user_model.dart';
import 'package:store_app2/repositories/user_repositories/abstract_user_repo.dart';

class LoginScreenViewModel with ChangeNotifier{
  bool spinner = false;
  TextDirection emailTextDirection = TextDirection.ltr;
  TextDirection passwordTextDirection = TextDirection.ltr;

  changeSpinner(bool spinnerOrNot){
    spinnerOrNot? spinner = true: spinner = false;
    notifyListeners();
  }

  emailOnChangeFun(BuildContext context, val){
    RegExp exp = RegExp("[a-zA-Z]");
    if(val != null){
      if(val.isNotEmpty){
        if(exp.hasMatch(val[val.length - 1])){
          emailTextDirection = TextDirection.ltr;
        }else{
          emailTextDirection = TextDirection.rtl;
        }
      }
    }
    notifyListeners();
  }

  passwordOnChangeFun(BuildContext context, val){
    RegExp exp = RegExp("[a-zA-Z]");
    if(val != null){
      if(val.isNotEmpty){
        if(exp.hasMatch(val[val.length - 1])){
          passwordTextDirection = TextDirection.ltr;
        }else{
          passwordTextDirection = TextDirection.rtl;
        }
      }
    }
    notifyListeners();
  }

  Future<void> signIn(BuildContext context, {required UserRepository userRepository,required UserModel userModel}) async{
    userRepository.signIn(userModel, context);
  }
}