import 'package:flutter/material.dart';
import 'package:store_app2/view_models/register_views_models/register_screen_view_model.dart';

import '../repositories/user_repositories/user_repo_firebase.dart';
import 'package:provider/provider.dart';
class  DrawerViewModel{
  List<Map<String, dynamic>> drawerRowList = [
    {"text": "حسابك", "icon" : Icons.person},
    {"text": "عربتك", "icon" : Icons.shopping_cart},
    {"text": "المفضله", "icon" : Icons.favorite},
    {"text": "الاعدادات", "icon" : Icons.settings_rounded},
    {"text": "اعرف عننا", "icon" : Icons.read_more_rounded},
    {"text": "تسجيل الخروج", "icon" : Icons.logout_rounded, "onTapFun" : (){
      RegisterScreenViewModel data = RegisterScreenViewModel();
      data.signOut(userRepository: UserRepoFirebase());
    }},
  ];
}