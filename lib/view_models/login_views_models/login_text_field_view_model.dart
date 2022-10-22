import 'package:flutter/material.dart';
import 'package:store_app2/constant.dart';

class LoginTextFieldViewModel with ChangeNotifier {
  IconData eyeIcon = Icons.visibility_off_rounded;
  Color eyeColor = Colors.grey;

  void changeEyeIconAndColor() {
    if (eyeIcon == Icons.visibility_off_rounded) {
      eyeIcon = Icons.visibility;
      eyeColor = kPrimaryColor;
    } else {
      eyeIcon = Icons.visibility_off_rounded;
      eyeColor = Colors.grey;
    }
    notifyListeners();
  }

  bool getItIsObscureOrNot(textInputType, provider) {
    return (textInputType == TextInputType.visiblePassword)
        ? (provider.eyeIcon == Icons.visibility)
            ? false
            : true
        : false;
  }
}
