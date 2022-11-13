import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/models/user_model.dart';
import 'package:store_app2/repositories/user_repositories/user_repo_firebase.dart';
import 'package:store_app2/view_models/user_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../view_models/setting_screens_view_model/change_name_screen_view_model.dart';
import '../../widgets/register_widgets/register_text_field_widget.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ChangeNameScreenViewModel>(context);
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
            child: Form(
              key: provider.key,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("UsersInfo").doc(UserRepoFirebase().getCurrentUserId()).snapshots(),
                  builder: (context, AsyncSnapshot snap){
                    return snap.hasData? ModalProgressHUD(
                      inAsyncCall: provider.spinner,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RegisterTextFieldWidget(
                            hint: snap.data["name"]/*"${userViewModel?.name}"*/,
                            textInputType: TextInputType.name,
                            controller: provider.nameController,
                            fieldTextDirection: provider.nameTextDirection,
                            onChangeFun: (val) {
                              provider.nameOnChangeFun(context, val);
                              provider.changeButtonColor(val);
                            },
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                if (val.length < 5) {
                                  return "name can't be less than 5 char";
                                }
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20.0,),
                          FloatingActionButton(
                            onPressed: provider.nameController.text.isEmpty? null:() async{
                              await provider.updateNameFun(
                                userRepository: UserRepoFirebase(),
                                userViewModel: UserViewModel(
                                    userModel: UserModel(name: provider.nameController.text)
                                ),
                              );
                            },
                            child: const Text("حفظ"),
                            backgroundColor: kTextColor,
                          ),
                        ],
                      ),
                    ): const Center(child: CircularProgressIndicator(),);
                  },
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
      title: const Text("قم بتغير اسمك"),
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
