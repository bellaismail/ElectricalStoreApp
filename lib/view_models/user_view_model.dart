import '../models/user_model.dart';
class UserViewModel {
  UserViewModel({this.userModel});
  UserModel? userModel;

  String? get name => userModel?.name;
  String? get email => userModel?.email;
  String? get image => userModel?.image;
  String? get password => userModel?.password;
  String? get currentUserId => userModel?.currentUserId;

  set name(n) => userModel!.name = n;
  set image(i) => userModel!.image = i;
  set email(e) => userModel!.email = e;
}