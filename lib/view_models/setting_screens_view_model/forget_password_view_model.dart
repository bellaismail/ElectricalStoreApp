import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app2/repositories/user_repositories/abstract_user_repo.dart';

class ForgetPasswordViewModel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextDirection textDirection = TextDirection.rtl;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  onChangeFun(val) {
    RegExp exp = RegExp("[a-zA-Z]");
    if (val != null) {
      if (val.isNotEmpty) {
        if (val[val.length - 1] == " ") {
          if (exp.hasMatch(val[val.length - 2])) {
            textDirection = TextDirection.ltr;
          } else {
            textDirection = TextDirection.rtl;
          }
        } else {
          if (exp.hasMatch(val[val.length - 1])) {
            textDirection = TextDirection.ltr;
          } else {
            textDirection = TextDirection.rtl;
          }
        }
      }
    }
    notifyListeners();
  }

  Future<void> onPressedFun({required UserRepository userRepository}) async {
    if (key.currentState!.validate()) {
      await userRepository
          .resetPassword(email: emailController.text.trim())
          .then((value) => {
                emailController.clear(),
              });
      notifyListeners();
    }
  }
}
