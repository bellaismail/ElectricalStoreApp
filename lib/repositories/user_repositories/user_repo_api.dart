import 'package:flutter/material.dart';
import 'package:store_app2/models/user_model.dart';
import 'package:store_app2/repositories/user_repositories/abstract_user_repo.dart';

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



}