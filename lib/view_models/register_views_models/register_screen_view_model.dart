import 'package:flutter/material.dart';
import 'package:store_app2/models/user_model.dart';
import 'package:store_app2/repositories/user_repositories/abstract_user_repo.dart';

class RegisterScreenViewModel with ChangeNotifier {
  bool spinner = false;
  IconData passwordIcon = Icons.visibility_off_rounded;
  IconData confirmIcon = Icons.visibility_off_rounded;

  changeSpinner(bool spinnerOrNot) {
    if (spinnerOrNot == true) {
      spinner = true;
      print("************$spinner 1***********");
    } else {
      spinner = false;
      print("************$spinner 2***********");
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

  changeConfirmIcon() {
    if (confirmIcon == Icons.visibility_off_rounded) {
      confirmIcon = Icons.visibility;
    } else {
      confirmIcon = Icons.visibility_off_rounded;
    }
    notifyListeners();
  }

  Future<void> registerFun({required UserRepository userRepository,required UserModel userModel}) async {
    // changeSpinner(true);
    await userRepository.signUp(userModel);
    // changeSpinner(false);
    notifyListeners();
  }
}
