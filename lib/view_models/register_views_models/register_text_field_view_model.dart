
import 'package:flutter/material.dart';

class RegisterTextFieldViewModel with ChangeNotifier{

  TextDirection textDirection = TextDirection.ltr;

  void changeEyeIcon(eyeIcon){
    if(eyeIcon == Icons.visibility_off_rounded){
      eyeIcon = Icons.visibility;
    }else{
      eyeIcon = Icons.visibility_off_rounded;
    }
    notifyListeners();
  }

}