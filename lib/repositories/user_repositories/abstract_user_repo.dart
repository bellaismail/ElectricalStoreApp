import 'package:store_app2/models/user_model.dart';
import 'package:flutter/material.dart';

abstract class UserRepository{
  Future<UserModel> getCurrentUserInfo({required String userDocId});
  String getCurrentUserId();
  Future<void> saveData(UserModel userModel);
  Future<void> signUp(UserModel userModel, BuildContext context);
  Future<void> signOut();

  Future<void> signIn(UserModel userModel, BuildContext context);
}