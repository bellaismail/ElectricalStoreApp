import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/models/user_model.dart';
import 'package:store_app2/repositories/user_repositories/abstract_user_repo.dart';
import 'package:store_app2/screens/auth_screens/login_screen.dart';
import 'package:store_app2/screens/home_screen.dart';
import 'package:store_app2/view_models/login_views_models/login_screen_view_model.dart';
import 'package:store_app2/view_models/register_views_models/register_screen_view_model.dart';

class UserRepoFirebase extends UserRepository {
  @override
  String getCurrentUserId() {
    String? userId;
    try {
      userId = FirebaseAuth.instance.currentUser?.uid;
    } catch (e) {
      throw Exception(
          "***SomeThing Wrong on getCurrentUserId Fun:=> $e :=>***");
    }
    return userId!;
  }

  @override
  Future<void> saveData(UserModel userModel) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection("UsersInfo");
    String userId = getCurrentUserId();
    try {
      await collection.doc(userId).set({
        "name": userModel.name,
        "email": userModel.email,
      }).then((value) => {
            print("*********userData saved Successful*********"),
          });
    } catch (e) {
      throw Exception("***SomeThing Wrong on saveData Fun:=> $e :=>***");
    }
  }

  @override
  Future<void> signUp(UserModel userModel, BuildContext context) async {
    ////////////////////////////////////////////////////
    var provider = Provider.of<RegisterScreenViewModel>(context, listen: false);
    try {
      provider.changeSpinner(true);
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: userModel.email!,
            password: userModel.password!,
          )
          .then((value) => {
                saveData(userModel).then((value) => {
                      Get.off(const HomeScreen())!
                          .then((value) => print("go to home screen")),
                    }),
              });
      provider.changeSpinner(false);
    } on FirebaseAuthException catch (e) {
      provider.changeSpinner(false);
      if (e.code == "email-already-in-use") {
        Get.snackbar(
          "خطأ",
          "",
          backgroundColor: Colors.orangeAccent,
          messageText: const Text(
            "هذا الحساب مستخدم بالفعل",
            style: TextStyle(
              color: kBackgroundColor,
            ),
          ),
        );
      } else {
        print("*****${e.code}****");
      }
    } catch (e) {
      provider.changeSpinner(false);
      throw Exception("***SomeThing Wrong on signUp Fun:=> $e :=>***");
    }
    ////////////////////////////////////////////////////
  }

  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut().then((value) => {
            Get.off(LoginScreen()),
          });
    } catch (e) {
      throw Exception("*** SomeThing Wrong on signOutFun $e ***");
    }
  }

  @override
  Future<void> signIn(UserModel userModel, BuildContext context) async {
    var provider = Provider.of<LoginScreenViewModel>(context, listen: false);
    try {
      provider.changeSpinner(true);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: userModel.email!,
            password: userModel.password!,
          )
          .then((value) => {
                Get.off(const HomeScreen()),
              });
      provider.changeSpinner(false);
    } on FirebaseAuthException catch (e) {
      provider.changeSpinner(false);
      if (e.code == "user-not-found") {
        Get.snackbar(
          "خطأ",
          "هذا البريد غير موجود",
          backgroundColor: Colors.orangeAccent,
        );
      } else if (e.code == "wrong-password") {
        Get.snackbar(
          "خطأ",
          "قد يكون البريد او كلمه السر غير صحيحين",
          backgroundColor: Colors.orangeAccent,
        );
      } else {
        print('***${e.code}///');
      }
    } catch (e) {
      provider.changeSpinner(false);
      throw Exception("*** SomeThing Wrong on signOutFun ${e.runtimeType} ***");
    }
  }

  @override
  Future<UserModel> getCurrentUserInfo({required String userDocId}) async {
    CollectionReference col =
        FirebaseFirestore.instance.collection("UsersInfo");
    var data;
    try {
      data = await col.doc(userDocId).get();
    } catch (e) {
      print("=== SomeThing Error on getCurrentUserInfoFun ${e.runtimeType} ===");
    }
    return UserModel(
      name: data["name"],
      email: data["email"],
      image: data["image"],
      currentUserId: getCurrentUserId()
    );
  }
}
