import 'package:flutter/material.dart';
class  DrawerViewModel{
  List<Map<String, dynamic>> drawerRowList = [
    {"text": "حسابك", "icon" : Icons.person},
    {"text": "عربتك", "icon" : Icons.shopping_cart},
    {"text": "المفضله", "icon" : Icons.favorite},
    {"text": "الاعدادات", "icon" : Icons.settings_rounded},
    {"text": "اعرف عننا", "icon" : Icons.read_more_rounded},
    {"text": "تسجيل الخروج", "icon" : Icons.logout_rounded},
  ];
}