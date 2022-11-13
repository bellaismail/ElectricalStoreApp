import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/models/user_model.dart';
import 'package:store_app2/repositories/user_repositories/user_repo_firebase.dart';
import 'package:store_app2/view_models/register_views_models/register_screen_view_model.dart';
import 'package:store_app2/widgets/register_widgets/snak_bar_widget.dart';
import '../../constant.dart';
import '../../widgets/login_widgets/socail_login_icon_widget.dart';
import '../../widgets/register_widgets/auth_top_clipPath_widget.dart';
import '../../widgets/register_widgets/register_text_field_widget.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var orient = MediaQuery.of(context).orientation;
    var provider = Provider.of<RegisterScreenViewModel>(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: null,
      body: Column(
        children: [
          // AuthTopClipPathWidget(text: "انشاء حساب"),
          Expanded(
            child: ModalProgressHUD(
              inAsyncCall: provider.spinner,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                child: Form(
                  key: _key,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(height: 150,),
                      RegisterTextFieldWidget(
                        hint: "الاسم",
                        textInputType: TextInputType.name,
                        controller: nameController,
                        fieldTextDirection: provider.nameTextDirection,
                        validator: (val) {
                          if (val != null) {
                            if (val.isEmpty) {
                              return "name can't be empty";
                            } else if (val.length < 5) {
                              return "name shouldn't be less than 5 char";
                            } else {
                              return null;
                            }
                          } else {
                            return null;
                          }
                        },
                        onChangeFun: (val) {
                          provider.nameOnChangeFun(context, val);
                        },
                      ),
                      RegisterTextFieldWidget(
                        hint: "xxx@example.com",
                        textInputType: TextInputType.emailAddress,
                        suffixIcon: Icons.alternate_email_rounded,
                        controller: emailController,
                        fieldTextDirection: provider.emailTextDirection,
                        validator: (val) {
                          // provider.emailValidator(val);
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
                        onChangeFun: (val) {
                          provider.emailOnChangeFun(context, val);
                        },
                      ),
                      RegisterTextFieldWidget(
                        hint: "كلمه السر",
                        textInputType: TextInputType.visiblePassword,
                        suffixIcon: provider.passwordIcon,
                        controller: passwordController,
                        fieldTextDirection: provider.passTextDirection,
                        validator: (val) {
                          if (val != null) {
                            if (val.length < 8) {
                              return "shouldn't be less than 8 char";
                            }
                          } else {
                            return "can't be empty";
                          }
                        },
                        iconButtonFun: () {
                          provider.changePasswordIcon();
                        },
                        onChangeFun: (val) {
                          provider.passwordOnChangeFun(context, val);
                        },
                      ),
                      RegisterTextFieldWidget(
                        hint: "تأكيد كلمه السر",
                        textInputType: TextInputType.visiblePassword,
                        suffixIcon: provider.confirmIcon,
                        controller: confirmController,
                        fieldTextDirection: provider.confirmTextDirection,
                        validator: (val) {
                          if (val != null) {
                            if (confirmController.text !=
                                passwordController.text) {
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
                      Padding(
                        padding: const EdgeInsets.all(kDefaultPadding / 2),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(kPrimaryColor),
                          ),
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
                                await provider
                                    .registerFun(
                                      context,
                                      userRepository: UserRepoFirebase(),
                                      userModel: UserModel(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                    )
                                    .then((value) => {
                                          nameController.clear(),
                                          emailController.clear(),
                                          passwordController.clear(),
                                          confirmController.clear(),
                                        });
                              }
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: kDefaultPadding / 1.5),
                            child: Text(
                              "انشاء حساب",
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("أمتلك حساب؟"),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
                            child: const Text(
                              "تسجيل الدخول",
                              style: TextStyle(
                                color: kPrimaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            drawer(),
                            const Text("أو"),
                            drawer(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SocialLoginIconWidget(
                              imagePath: "images/google_logo.png",
                              onTapFun: ()async{
                                await provider.signInWithGoogle(
                                  context: context,
                                  userRepository: UserRepoFirebase()
                                );
                                // await FirebaseAuth.instance.signOut();
                              },
                            ),
                            SocialLoginIconWidget(
                              imagePath: "images/facebook_logo.png",
                              onTapFun: ()async{
                                await provider.signInWithFacebook(
                                  context: context,
                                  userRepository: UserRepoFirebase(),
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
          ),
        ],
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
