import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/models/user_model.dart';
import 'package:store_app2/repositories/user_repositories/user_repo_firebase.dart';
import 'package:store_app2/screens/auth_screens/register_screen.dart';
import 'package:store_app2/view_models/login_views_models/login_screen_view_model.dart';
import 'package:store_app2/view_models/register_views_models/register_screen_view_model.dart';
import 'package:store_app2/widgets/login_widgets/login_text_field_widget.dart';

import '../../widgets/register_widgets/auth_top_clipPath_widget.dart';
import '../../widgets/register_widgets/snak_bar_widget.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var orient = MediaQuery.of(context).orientation;
    var provider = Provider.of<LoginScreenViewModel>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: null,
      body: Container(
        child: Column(
          children: [
            AuthTopClipPathWidget(text: 'تسجيل الدخول'),
            Form(
              key: _key,
              child: Expanded(
                child: ModalProgressHUD(
                  inAsyncCall: provider.spinner,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                      vertical: kDefaultPadding / 2,
                    ),
                    child: ListView(
                      children: [
                        orient == Orientation.portrait? const SizedBox(height: 30.0,):const SizedBox(),
                        LoginTextFieldWidget(
                          hint: "xxx@example.com",
                          textInputType: TextInputType.emailAddress,
                          controller: emailController,
                          fieldTextDirection: provider.emailTextDirection,
                          validationFun: (val) {
                            if (val != null) {
                              if (val.isEmpty) {
                                return "can't be empty";
                              } else if (!RegExp(
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                  .hasMatch(val)) {
                                return "format email not valid";
                              }
                            } else {
                              return "can't be empty";
                            }
                          },
                          onChangeFun: (val){
                            provider.emailOnChangeFun(context, val);
                          },
                        ),
                        LoginTextFieldWidget(
                          hint: "ادخل كلمه السر",
                          textInputType: TextInputType.visiblePassword,
                          controller: passwordController,
                          fieldTextDirection: provider.passwordTextDirection,
                          validationFun: (val) {
                            if (val == null || val.isEmpty) {
                              return "can't be Empty";
                            }
                          },
                          onChangeFun: (val){
                            provider.passwordOnChangeFun(context, val);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(kDefaultPadding / 2),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kPrimaryColor)),
                            onPressed: () async {
                              var connectivityResult =
                                  await (Connectivity().checkConnectivity());
                              if (_key.currentState!.validate()) {
                                if (connectivityResult !=
                                        ConnectivityResult.wifi &&
                                    connectivityResult !=
                                        ConnectivityResult.mobile) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    snackBarWidget(
                                      "تأكد من اتصال الانترنت لديك",
                                      color: Colors.redAccent,
                                    ),
                                  );
                                } else {
                                  UserModel userModel = UserModel(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  await provider.signIn(
                                    context,
                                    userRepository: UserRepoFirebase(),
                                    userModel: userModel,
                                  ).then((value) => {
                                    emailController.clear(),
                                    passwordController.clear(),
                                  });
                                }
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: kDefaultPadding / 1.5),
                              child: Text(
                                "تسجيل الدخول",
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text("لا تمتلك حساب؟"),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()),
                                );
                              },
                              child: const Text(
                                "انشاء حساب",
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding drawer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 1,
        width: 130,
        color: Colors.grey,
      ),
    );
  }
}

/*
* AuthTopClipPathWidget(text: 'تسجيل الدخول'),
* */

/*
*
* */
