import 'package:flutter/material.dart';
import 'package:store_app2/models/user_model.dart';
import 'package:store_app2/repositories/user_repositories/abstract_user_repo.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/view_models/login_views_models/login_text_field_view_model.dart';

class LoginScreenViewModel with ChangeNotifier{
  bool spinner = false;

  changeSpinner(bool spinnerOrNot){
    spinnerOrNot? spinner = true: spinner = false;
    notifyListeners();
  }

  onChangeFun(BuildContext context, val){
    var provider = Provider.of<LoginTextFieldViewModel>(context, listen: false);
    provider.changeTextFieldDirection(val);
    notifyListeners();
  }

  Future<void> signIn(BuildContext context, {required UserRepository userRepository,required UserModel userModel}) async{
    userRepository.signIn(userModel, context);
  }
}