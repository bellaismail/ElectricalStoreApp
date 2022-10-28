import '../models/user_model.dart';

class UserViewModel {
  UserViewModel({this.userModel});
  UserModel? userModel;

  String? get name => userModel?.name;
  String? get email => userModel?.email;
  String? get image => userModel?.image;
  String? get currentUserId => userModel?.currentUserId;
}