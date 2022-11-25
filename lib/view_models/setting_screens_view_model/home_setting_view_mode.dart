import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/repositories/user_repositories/abstract_user_repo.dart';
import 'package:store_app2/view_models/drawer_view_model.dart';

import '../user_view_model.dart';

class HomeSettingViewModel extends ChangeNotifier {
  final String appBarTitle = "الاعدادات";
  UserViewModel? userViewModel;
  bool showCountDown = false;
  int countDownNum = 10;
  bool removeAccount = false;
  bool confirmDelete = false;
  bool rejectDelete = false;
  bool spinner = false;

  changeName(context){
    try{
      var provider = Provider.of<DrawerViewModel>(context, listen: false);
      provider.userViewModel!.name = "Bilal";
      notifyListeners();
    }on StackOverflowError catch(e){
      print("e: ${e}");
    }
    print("=== ${userViewModel!.name} ===");
    print("=== ${userViewModel!.email} ===");
    print("=== ${userViewModel!.image} ===");
    notifyListeners();
  }

  getUserData({required BuildContext context})async{
    var provider = Provider.of<DrawerViewModel>(context, listen: false);
    userViewModel = provider.userViewModel;
  }
  profileImage({required AsyncSnapshot snapshot}) {
    return snapshot.data["image"] == ""
        ? const AssetImage("images/profile.png")
        : NetworkImage(
      "${snapshot.data["image"]}",
    );
  }
  Future<void> deleteAccount({required UserRepository userRepository})async{
    spinner = true;
    await userRepository.deleteAccountAuth();
    spinner = false;
    notifyListeners();
  }
  void countDownFun({required UserRepository userRepository}) async {
    loop:
    for (int i = 10; i >= 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      if(countDownNum != 0){
        if(confirmDelete){
          showCountDown = false;
          notifyListeners();
          await deleteAccount(userRepository: userRepository);
          break loop;
        }else if(rejectDelete){
          showCountDown = false;
          notifyListeners();
          break loop;
        }else{
          countDownNum--;
          notifyListeners();
        }
      }else{
        showCountDown = false;
        notifyListeners();
      }
    }
  }
  removeAccountOnPressed({required UserRepository userRepository}){
    showCountDown = true;
    confirmDelete = false;
    rejectDelete = false;
    countDownNum = 10;
    countDownFun(userRepository: userRepository);
    notifyListeners();
  }
  pickImageFun(ImageSource imageSource, {required UserRepository userRepository})async{
    var randomNum = Random().nextInt(1000000);
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage = await imagePicker.pickImage(source: imageSource);
    String imagePath = pickedImage!.path;
    String imageName = "$randomNum${pickedImage.name}";
    File file = File(imagePath);
    spinner = true;
    await userRepository.pickImageToStorage(file: file, imageName: imageName);
    spinner = false;
    notifyListeners();
  }
}
