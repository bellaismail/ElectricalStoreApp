
import 'package:flutter/material.dart';

class RegisterTextFieldViewModel with ChangeNotifier{

  TextDirection textDirection = TextDirection.ltr;

  void changeTextFieldDirection(val){
    RegExp exp = RegExp("[a-zA-Z]");
    if(exp.hasMatch(val[val.length - 1]) && val[val.length - 1] != " "){
      textDirection = TextDirection.ltr;
    }else{
      textDirection = TextDirection.rtl;
    }
    notifyListeners();
  }
  void changeEyeIcon(eyeIcon){
    if(eyeIcon == Icons.visibility_off_rounded){
      eyeIcon = Icons.visibility;
      print("111111111111111111111");
    }else{
      eyeIcon = Icons.visibility_off_rounded;
      print("2222222222222222222222222");
    }
    notifyListeners();
  }

}