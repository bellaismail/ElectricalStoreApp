import 'dart:io';
import 'package:flutter/material.dart';
import 'package:store_app2/models/user_model.dart';
import 'package:store_app2/repositories/user_repositories/abstract_user_repo.dart';

import '../../view_models/user_view_model.dart';

class UserRepoAPI extends UserRepository{

  @override
  String getCurrentUserId() {
    // TODO: implement getCurrentUserId
    throw UnimplementedError();
  }

  @override
  Future<void> saveData(UserModel userModel) {
    // TODO: implement saveData
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(UserModel userModel, BuildContext context) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(UserModel userModel, BuildContext context) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<UserModel> getCurrentUserInfo({required String userDocId}) {
    // TODO: implement getCurrentUserInfo
    throw UnimplementedError();
  }

  @override
  Future<void> uploadImage({required String? imagePath, required File? file}) {
    // TODO: implement uploadImage
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithFacebook({required BuildContext context}) {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithGoogle({required BuildContext context}) {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }


  @override
  Future<void> updateName({required UserViewModel userViewModel}) {
    // TODO: implement updateName
    throw UnimplementedError();
  }

  @override
  Future<void> updatePassword({required UserViewModel userViewModel}) {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }

  @override
  Future<void> updateEmailOnAuth(String? newEmail) {
    // TODO: implement updateEmailOnAuth
    throw UnimplementedError();
  }

  @override
  Future<void> updateEmail({required UserViewModel userViewModel, String? newEmail}) {
    // TODO: implement updateEmail
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword({required String email}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<void> verifyEmail() {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAccountAuth() {
    // TODO: implement deleteAccountAuth
    throw UnimplementedError();
  }


  @override
  Future<void> pickImageToStorage({required File file, required String? imageName}) {
    // TODO: implement pickImageToStorage
    throw UnimplementedError();
  }

  @override
  Future<void> saveImagePathToFirestore({required String path}) {
    // TODO: implement saveImagePathToFirestore
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAccountFirestore(String docId) {
    // TODO: implement deleteAccountFirestore
    throw UnimplementedError();
  }




}