import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/models/user_model.dart';
import 'package:store_app2/repositories/user_repositories/user_repo_firebase.dart';
import 'package:store_app2/view_models/user_view_model.dart';
import '../../view_models/setting_screens_view_model/change_email_screen_view_model.dart';
import '../../widgets/register_widgets/register_text_field_widget.dart';

class ChangeEmailScreen extends StatelessWidget {
  const ChangeEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ChangeEmailScreenViewModel>(context);
    var size = MediaQuery.of(context);
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
            child: Form(
              key: provider.key,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("UsersInfo")
                    .doc(UserRepoFirebase().getCurrentUserId())
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ModalProgressHUD(
                      inAsyncCall: provider.spinner,
                      child: ListView(
                        children: [
                          SizedBox(height: size.orientation == Orientation.landscape? 0.0:150.0,),
                          RegisterTextFieldWidget(
                            hint:
                            "${snapshot.data["email"]}" /*"${userViewModel?.email}"*/,
                            textInputType: TextInputType.emailAddress,
                            controller: provider.emailController,
                            fieldTextDirection: provider.emailTextDirection,
                            suffixIcon: Icons.alternate_email_rounded,
                            onChangeFun: (val) {
                              provider.emailOnChangeFun(context, val);
                            },
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                if (val.length < 5) {
                                  return "email can't be less than 5 char";
                                } else if (!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                    .hasMatch(val)) {
                                  return "format email not valid";
                                }
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            width: 70.0,
                            height: 70.0,
                            child: FloatingActionButton(
                              onPressed: provider.emailController.text.isEmpty
                                  ? null
                                  : () async {
                                await provider.updateEmailFun(
                                  userRepository: UserRepoFirebase(),
                                  userViewModel: UserViewModel(
                                    userModel: UserModel(
                                        email: provider.emailController.text),
                                  ),
                                );
                              },
                              child: const Text("حفظ"),
                              backgroundColor: kTextColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  AppBar appBar(){
    return AppBar(
      title: const Text("قم بتغير ايميلك"),
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
