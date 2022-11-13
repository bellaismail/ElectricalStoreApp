import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/models/user_model.dart';
import 'package:store_app2/repositories/user_repositories/user_repo_firebase.dart';
import 'package:store_app2/view_models/setting_screens_view_model/change_password_screen_view_model.dart';
import 'package:store_app2/view_models/user_view_model.dart';

import '../../widgets/register_widgets/register_text_field_widget.dart';
import '../../widgets/setting/forget_password_modal_sheet_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ChangePasswordScreenViewModel>(context);
    MediaQueryData size = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: appBar(),
      body: Stack(
        children: [
          CustomPaint(
            painter: Painter(orientation: size),
            child: Container(
              width: double.infinity,
              height: size.size.height,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ModalProgressHUD(
              inAsyncCall: provider.spinner,
              child: Form(
                key: provider.key,
                child: ListView(
                  children: [
                    SizedBox(height: size.orientation == Orientation.landscape? 0.0:50.0,),
                    RegisterTextFieldWidget(
                      hint: "كلمه السر",
                      textInputType: TextInputType.visiblePassword,
                      controller: provider.passwordController,
                      fieldTextDirection: provider.passTextDirection,
                      suffixIcon: provider.passwordIcon,
                      onChangeFun: (val) {
                        provider.passwordOnChangeFun(context, val);
                        // provider.changeButtonColor(val);
                      },
                      iconButtonFun: () {
                        provider.changePasswordIcon();
                      },
                      validator: (val) {
                        if (val!.isNotEmpty) {
                          if (val.length < 5) {
                            return "password can't be less than 5 char";
                          }
                        }
                        return null;
                      },
                    ),
                    RegisterTextFieldWidget(
                      hint: "تأكيد كلمه السر",
                      textInputType: TextInputType.visiblePassword,
                      suffixIcon: provider.confirmIcon,
                      controller: provider.confirmController,
                      fieldTextDirection: provider.confirmTextDirection,
                      validator: (val) {
                        if (val!.isNotEmpty) {
                          if (provider.confirmController.text !=
                              provider.passwordController.text) {
                            return "not right";
                          }
                        }
                      },
                      iconButtonFun: () {
                        provider.changeConfirmIcon();
                      },
                      onChangeFun: (val) {
                        provider.confirmOnChangeFun(context, val);
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: ForgetPasswordModalSheetWidget(),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "نسيت كلمه السر؟",
                        style: TextStyle(
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 70.0,
                      height: 70.0,
                      child: FloatingActionButton(
                        onPressed: provider.passwordController.text.isEmpty
                            ? null
                            : () async {
                          UserModel user = UserModel(
                              password: provider.passwordController.text);
                          UserViewModel userViewModel =
                          UserViewModel(userModel: user);
                          await provider.updatePassword(
                              userRepository: UserRepoFirebase(),
                              userViewModel: userViewModel);
                        },
                        child: const Text(
                          "حفظ",
                          style: TextStyle(),
                        ),
                        backgroundColor: kTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  AppBar appBar(){
    return AppBar(
      title: const Text("تغير كلمه السر"),
      elevation: 0.0,
      backgroundColor: kTextColor,
    );
  }
}

class Painter extends CustomPainter{
  Painter({this.orientation});
  MediaQueryData? orientation;
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;

    if(orientation!.orientation == Orientation.landscape){
      path..moveTo(0, 0)
        ..lineTo(0, h * .4)
        ..quadraticBezierTo(w - (w - 60), h , w - (w - 150), h - 70)
        ..quadraticBezierTo(w / 2, h - 250, w, h - 200)
        ..lineTo(w, 0)
        ..close();
    }else{
      path
        ..moveTo(0, 0)
        ..lineTo(0, h * .8)
        ..quadraticBezierTo(w - (w - 50), h - 50, w - (w - 100), h - 100)
        ..quadraticBezierTo(w / 2, h - 200, w, h - 250)
        ..lineTo(w, 0)
        ..close();
    }
    Paint paint = Paint()..color = kTextColor..strokeCap = StrokeCap.round;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}
