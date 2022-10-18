import 'package:flutter/material.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/screens/auth_screens/register_screen.dart';
import 'package:store_app2/screens/home_screen.dart';
import 'package:store_app2/widgets/login_widgets/login_text_field_widget.dart';
import 'package:store_app2/widgets/login_widgets/socail_login_icon_widget.dart';

import '../../widgets/register_widgets/auth_top_clipPath_widget.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var orient = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: null,
      body: Container(
        child: Column(
          children: [
            // AuthTopClipPathWidget(text: 'تسجيل الدخول'),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 2,
                ),
                child: ListView(
                  children: [
                    LoginTextFieldWidget(
                      hint: "xxxx@xxx.com",
                      textInputType: TextInputType.emailAddress,
                    ),
                    LoginTextFieldWidget(
                      hint: "ادخل كلمه السر",
                      textInputType: TextInputType.visiblePassword,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(kDefaultPadding / 2),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(kPrimaryColor)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()),
                          );
                        },
                        child: const Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: kDefaultPadding / 1.5),
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
                              MaterialPageRoute(builder: (context) => RegisterScreen()),
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
