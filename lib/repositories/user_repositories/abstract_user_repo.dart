import 'package:store_app2/models/user_model.dart';

abstract class UserRepository{
  Future<UserModel> getCurrentUserInfo();
  String getCurrentUserId();
  Future<void> saveData(UserModel userModel);
  Future<void> signUp(UserModel userModel);
  Future<void> signOut();
}