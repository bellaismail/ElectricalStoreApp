import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app2/repositories/user_repositories/abstract_user_repo.dart';
import 'package:store_app2/screens/cart_screen.dart';
import 'package:store_app2/screens/favorite_screen.dart';
import 'package:store_app2/screens/setting_screens/home_setting_screen.dart';
import 'package:store_app2/view_models/register_views_models/register_screen_view_model.dart';
import 'package:store_app2/view_models/user_view_model.dart';
import '../models/user_model.dart';
import '../repositories/user_repositories/user_repo_firebase.dart';
import '../screens/about_screen.dart';

class DrawerViewModel with ChangeNotifier{
  UserViewModel? userViewModel;
  final UserRepository userRepository;
  DrawerViewModel({required this.userRepository});

  bool signOut = false;
  List<Map<String, dynamic>> drawerRowList = [
    {
      "text": "عربتك",
      "icon": Icons.shopping_cart,
      "onTapFun": (){
        Get.back();
        Get.to(CartScreen());
      }
    },
    {
      "text": "المفضله",
      "icon": Icons.favorite,
      "onTapFun": () {
        Get.back();
        Get.to(FavoriteScreen());
      },
    },
    {
      "text": "اعرف عننا",
      "icon": Icons.read_more_rounded,
      "onTapFun": () {
        Get.back();
        Get.to(const AboutScreen());
      },
    },
    {
      "text": "الاعدادات",
      "icon": Icons.settings_rounded,
      "onTapFun": (){
        Get.back();
        Get.to(HomeSettingScreen());
      }
    },
    {
      "text": "تسجيل الخروج",
      "icon": Icons.logout_rounded,
      "onTapFun": (){
        RegisterScreenViewModel data = RegisterScreenViewModel();
        data.signOut(userRepository: UserRepoFirebase());
      },
    },
  ];

  confirmSignOut(){
    signOut = true;
    notifyListeners();
  }
  rejectSignOut(){
    signOut = false;
    notifyListeners();
  }
  Future<void> getUserData({required UserRepository userRepository}) async {
    String userDocId = userRepository.getCurrentUserId();
    UserModel userModel = await userRepository.getCurrentUserInfo(userDocId: userDocId);
    userViewModel =  UserViewModel(userModel: userModel);
    notifyListeners();
  }

  profileImage({required UserViewModel userViewModel}){
    return userViewModel.image!.isEmpty? const AssetImage("images/profile.png"):NetworkImage(
      "${userViewModel.image}",
    );
  }
}
