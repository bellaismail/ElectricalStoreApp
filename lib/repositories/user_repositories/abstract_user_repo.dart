import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:store_app2/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:store_app2/view_models/user_view_model.dart';

abstract class UserRepository{
  Future<UserModel> getCurrentUserInfo({required String userDocId});
  String getCurrentUserId();
  Future<void> saveData(UserModel userModel);
  Future<void> signUp(UserModel userModel, BuildContext context);
  Future<void> signOut();
  Future<void> signIn(UserModel userModel, BuildContext context);
  Future<void> signInWithGoogle({required BuildContext context});
  Future<void> signInWithFacebook({required BuildContext context});
  Future<void> updateName({required UserViewModel userViewModel});
  Future<void> updateEmailOnAuth(String? newEmail);
  Future<void> updateEmail({required UserViewModel userViewModel, String? newEmail});
  Future<void> updatePassword({required UserViewModel userViewModel});
  Future<void> verifyEmail();
  Future<void> resetPassword({required String email});
  Future<void> deleteAccountAuth();
  Future<void> deleteAccountFirestore();
  Future<void> pickImageToStorage({required File file, required String? imageName});
  Future<void> saveImagePathToFirestore({required String path});
}