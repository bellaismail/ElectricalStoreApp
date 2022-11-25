import '';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/repositories/user_repositories/user_repo_firebase.dart';
import 'package:store_app2/screens/setting_screens/change_email_screen.dart';
import 'package:store_app2/screens/setting_screens/change_name_screen.dart';
import 'package:store_app2/screens/setting_screens/change_password_screen.dart';
import 'package:store_app2/view_models/drawer_view_model.dart';
import 'package:store_app2/view_models/setting_screens_view_model/home_setting_view_mode.dart';
import 'package:sqflite/sqflite.dart';

class HomeSettingScreen extends StatefulWidget {
  @override
  State<HomeSettingScreen> createState() => _HomeSettingScreenState();
}

class _HomeSettingScreenState extends State<HomeSettingScreen> {
  final _key = GlobalKey<FormState>();
  @override
  void initState() {
    var provider = Provider.of<HomeSettingViewModel>(context, listen: false);
    provider.getUserData(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var docId = UserRepoFirebase().getCurrentUserId();
    var stream = FirebaseFirestore.instance.collection("UsersInfo").doc(docId).snapshots();
    var provider = Provider.of<HomeSettingViewModel>(context);
    var drawerProvider = Provider.of<DrawerViewModel>(context);
    var size = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: appBar(provider),
      body: ModalProgressHUD(
        inAsyncCall: provider.spinner,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height:
              (size.orientation != Orientation.portrait) ? 100 : 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    painter: Painter2(),
                    child: const SizedBox(
                      height: 200,
                      width: double.infinity,
                    ),
                  ),
                  CustomPaint(
                    painter: Painter1(),
                    child: const SizedBox(
                      height: 200,
                      width: double.infinity,
                    ),
                  ),
                  StreamBuilder(
                      stream: stream,
                      builder: (context, AsyncSnapshot snapshot){
                        if(snapshot.hasData){
                          return Container(
                            width: 150.0,
                            height: 150.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black45,
                                  offset: Offset(0, 0),
                                  blurRadius: 10.0,
                                ),
                              ],
                              image: DecorationImage(
                                image: provider.profileImage(snapshot: snapshot),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }else{
                          return const Center(child: CircularProgressIndicator(),);
                        }
                  }),
                  Positioned(
                    bottom: 0.0,
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: IconButton(
                        onPressed: () async {
                          buttomSheetWidget(
                            size,
                            provider,
                          );
                        },
                        icon: const Icon(
                          Icons.add_a_photo_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Form(
                key: _key,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 0.0,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(const ChangeNameScreen());
                                  },
                                  child: const ListTile(
                                    trailing: Icon(Icons.arrow_forward_ios),
                                    title: Text("تغييرالاسم"),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 0.0,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(const ChangeEmailScreen());
                                  },
                                  child: const ListTile(
                                    trailing: Icon(Icons.arrow_forward_ios),
                                    title: Text("تغيير الايميل"),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 0.0,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(const ChangePasswordScreen());
                                  },
                                  child: const ListTile(
                                    trailing: Icon(Icons.arrow_forward_ios),
                                    title: Text("تغيير كلمه السر"),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await provider.removeAccountOnPressed(
                                      userRepository: UserRepoFirebase());
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    "حذف الحساب",
                                    style: TextStyle(
                                      color: kBackgroundColor,
                                    ),
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(kTextColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      !provider.showCountDown
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          provider.confirmDelete = true;
                                        },
                                        child: const Text(
                                          "تأكيد",
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          provider.rejectDelete = true;
                                        },
                                        child: const Text(
                                          "الغاء",
                                          style: TextStyle(color: kTextColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Selector<HomeSettingViewModel, int>(
                                    selector: (context, getCountDown) =>
                                        getCountDown.countDownNum,
                                    builder: (context, countDown, child) {
                                      return CustomPaint(
                                        painter: CirclePainter(),
                                        child: Container(
                                          width: 50.0,
                                          height: 50.0,
                                          alignment: Alignment.center,
                                          child: Text("$countDown"),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  AppBar appBar(provider) {
    return AppBar(
      backgroundColor: kTextColor,
      elevation: 0.0,
      title: Text(provider.appBarTitle),
    );
  }
  buttomSheetWidget(MediaQueryData size, provider) async{
    await Get.bottomSheet(
      SizedBox(
        width: double.infinity,
        height: size.orientation == Orientation.landscape ? 100 : 200.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ColumnModelSheet(
              text: "التقاط",
              iconData: Icons.camera_rounded,
              onTap: ()async{
                await provider.pickImageFun(ImageSource.camera, userRepository: UserRepoFirebase());
              },
            ),
            ColumnModelSheet(
              text: "تحميل",
              iconData: Icons.photo_library_rounded,
              onTap: ()async{
                await provider.pickImageFun(ImageSource.gallery, userRepository: UserRepoFirebase());
              },
            ),
          ],
        ),
      ),
      backgroundColor: kTextColor.withOpacity(0.7),
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12.0),
          topLeft: Radius.circular(12.0),
        ),
        borderSide: BorderSide.none,
      ),
    );
  }
}
class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = kTextColor
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(const Offset(25, 25), 20.0, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
class Painter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;

    path
      ..moveTo(0, 0)
      ..lineTo(0, h / 1.5)
      ..lineTo(w, 0)
      ..close();

    Paint paint = Paint()..color = kTextColor;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
class Painter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;

    path
      ..moveTo(w, 0)
      ..lineTo(w, h / 1.5)
      ..lineTo(0, 0)
      ..close();

    Paint paint = Paint()..color = kTextColor;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
class ColumnModelSheet extends StatelessWidget {
  const ColumnModelSheet({
    key,
    this.text,
    this.iconData,
    this.onTap,
  }) : super(key: key);

  final IconData? iconData;
  final String? text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            iconData,
            color: kBackgroundColor,
          ),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 1.5),
            child: Text(
              text!,
              style: const TextStyle(color: kBackgroundColor),
            ),
          ),
        ],
      ),
    );
  }
}
