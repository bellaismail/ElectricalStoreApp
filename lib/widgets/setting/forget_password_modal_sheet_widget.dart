import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/repositories/user_repositories/user_repo_firebase.dart';
import 'package:store_app2/view_models/setting_screens_view_model/change_password_screen_view_model.dart';
import 'package:store_app2/view_models/setting_screens_view_model/forget_password_view_model.dart';

import '../../constant.dart';

class ForgetPasswordModalSheetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ForgetPasswordViewModel>(context);
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Form(
        key: provider.key,
        child: Column(
          children: [
            TextFormField(
              onChanged: (val) {
                provider.onChangeFun(val);
              },
              controller: provider.emailController,
              autofocus: true,
              textDirection: provider.textDirection,
              cursorColor: Colors.grey,
              validator: (val){
                if(val!.isNotEmpty){
                  if(val.length < 5){
                    return "can't be less than 5 char";
                  }else if(!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(val)){
                    return "format email not valid";
                  }
                }else{
                  return "can't be Empty";
                }
              },
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "أدخل ايميلك",
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  suffixIcon: const Icon(Icons.alternate_email_rounded)
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: ElevatedButton(
                onPressed:()async{
                  await provider.onPressedFun(userRepository: UserRepoFirebase());
                },
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(kTextColor),
                ),
                child: const Text(
                  "ارسال",
                  style: TextStyle(
                    color: kBackgroundColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}