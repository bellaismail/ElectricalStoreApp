import 'package:flutter/material.dart';
import 'package:store_app2/models/user_model.dart';
import 'package:store_app2/repositories/user_repositories/abstract_user_repo.dart';

class RegisterScreenViewModel with ChangeNotifier {
  bool spinner = false;
  IconData passwordIcon = Icons.visibility_off_rounded;
  IconData confirmIcon = Icons.visibility_off_rounded;

  TextDirection nameTextDirection = TextDirection.rtl;
  TextDirection emailTextDirection = TextDirection.rtl;
  TextDirection passTextDirection = TextDirection.rtl;
  TextDirection confirmTextDirection = TextDirection.rtl;

  changeSpinner(bool spinnerOrNot) {
    spinnerOrNot? spinner = true : spinner = false;
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
  changeConfirmIcon() {
    if (confirmIcon == Icons.visibility_off_rounded) {
      confirmIcon = Icons.visibility;
    } else {
      confirmIcon = Icons.visibility_off_rounded;
    }
    notifyListeners();
  }

  nameOnChangeFun(BuildContext context, val){
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
  emailOnChangeFun(BuildContext context, val){
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
  passwordOnChangeFun(BuildContext context, val){
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

  Future<void> registerFun(BuildContext context,{required UserRepository userRepository,required UserModel userModel}) async {
    await userRepository.signUp(userModel, context);
    notifyListeners();
  }
  Future<void> signOut({required UserRepository userRepository})async{
    await userRepository.signOut();
  }
  Future<void> signInWithGoogle({UserRepository? userRepository, required BuildContext context}) async {
    await userRepository!.signInWithGoogle(context: context);
  }
  Future<void> signInWithFacebook({required BuildContext context, UserRepository? userRepository}) async {
    await userRepository!.signInWithFacebook(context: context);
  }
}
