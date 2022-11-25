import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/models/user_model.dart';
import 'package:store_app2/repositories/user_repositories/abstract_user_repo.dart';
import 'package:store_app2/screens/auth_screens/login_screen.dart';
import 'package:store_app2/screens/home_screen.dart';
import 'package:store_app2/view_models/login_views_models/login_screen_view_model.dart';
import 'package:store_app2/view_models/register_views_models/register_screen_view_model.dart';

import '../../view_models/user_view_model.dart';

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
        "image": "",
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
      print(
          "=== SomeThing Error on getCurrentUserInfoFun ${e.runtimeType} ===");
    }
    return UserModel(
        name: data["name"],
        email: data["email"],
        image: data["image"],
        currentUserId: getCurrentUserId());
  }
  @override
  Future<void> signInWithGoogle({required BuildContext context}) async {
    var provider = Provider.of<RegisterScreenViewModel>(context, listen: false);
    FirebaseAuth auth = FirebaseAuth.instance;
    var googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      var googleAuth = await googleUser.authentication;
      var credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      try {
        provider.changeSpinner(true);
        await auth.signInWithCredential(credential);
        await saveData(UserModel(
          name: googleUser.displayName,
          email: googleUser.email,
        )).then((value) => {Get.off(const HomeScreen())});
        provider.changeSpinner(false);
      } on FirebaseAuthException catch (e) {
        provider.changeSpinner(false);
        print("=== ${e.code} ===");
      } catch (e) {
        provider.changeSpinner(false);
        print("=== $e ===");
      }
    }
  }
  @override
  Future<void> signInWithFacebook({required BuildContext context}) async {
    var provider = Provider.of<RegisterScreenViewModel>(context, listen: false);
    FirebaseAuth auth = FirebaseAuth.instance;
    var facebookUser = await FacebookAuth.instance.login();
    if (facebookUser.accessToken != null) {
      var credential =
          FacebookAuthProvider.credential(facebookUser.accessToken!.token);
      try {
        provider.changeSpinner(true);
        await auth.signInWithCredential(credential);
        await saveData(
          UserModel(
            name: auth.currentUser!.displayName,
            email: auth.currentUser!.email,
          ),
        ).then((value) => {Get.off(const HomeScreen())});
        provider.changeSpinner(false);
      } on FirebaseAuthException catch (e) {
        provider.changeSpinner(false);
        print("=== ${e.code} ===");
      } catch (e) {
        provider.changeSpinner(false);
        print("=== someThing Wrong on $e ===");
      }
    }
  }
  @override
  Future<void> updateName({required UserViewModel userViewModel}) async {
    CollectionReference c = FirebaseFirestore.instance.collection("UsersInfo");
    String userId = getCurrentUserId();
    try {
      await c.doc(userId).update({
        "name": userViewModel.name,
      });
    } catch (e) {
      print("=== someThing error on update name${e.runtimeType} ===");
    }
  }
  @override
  Future<void> updateEmailOnAuth(String? newEmail) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.currentUser!.updateEmail("$newEmail");
    } catch (e) {
      print("=== $e ===");
    }
  }
  @override
  Future<void> updateEmail({required UserViewModel userViewModel, String? newEmail}) async {
    CollectionReference c = FirebaseFirestore.instance.collection("UsersInfo");
    String userId = getCurrentUserId();
    try {
      await updateEmailOnAuth(newEmail);
      await c.doc(userId).update({
        "email": userViewModel.email,
      });
    } catch (e) {
      print("=== someThing error on update email${e.runtimeType} ===");
    }
  }
  @override
  Future<void> updatePassword({required UserViewModel userViewModel}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.currentUser?.updatePassword(userViewModel.password!);
    } catch (e) {
      print("=== someThing error: $e ===");
    }
  }
  @override
  Future<void> resetPassword({required String email}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.sendPasswordResetEmail(email: email).then((value) => {
            Get.back(),
        Get.snackbar(
          "check",
          "check",
          backgroundColor: Colors.green,
          colorText: kBackgroundColor,
        ),
          });
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        Get.snackbar(
          "خطأ",
          "هذا الايميل غير موجود",
          backgroundColor: Colors.redAccent,
          colorText: kBackgroundColor,
        );
      }
    }catch(e) {
      print("=== === $e === ===");
    }
  }
  @override
  Future<void> verifyEmail() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (!auth.currentUser!.emailVerified) {
      await auth.currentUser!.sendEmailVerification();
    }
  }
  @override
  Future<void> deleteAccountAuth() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    String docId = getCurrentUserId();
    try{

      await auth.currentUser!.delete();
      Get.offAll(LoginScreen());
      await deleteAccountFirestore(docId);

    }catch(e){
      print("=== === $e === ===");
    }
  }
  @override
  Future<void> deleteAccountFirestore(String docId) async{
    CollectionReference c = FirebaseFirestore.instance.collection("UsersInfo");
    try{
      await c.doc(docId).delete();
    }catch(e){
      print("=== === $e === ===");
    }
  }
  @override
  Future<void> pickImageToStorage({required File file, required String? imageName}) async{
    var storage = FirebaseStorage.instance.ref(getCurrentUserId()).child("$imageName");
    String url;
    try{
      await storage.putFile(file);
      Get.back();
      url = await storage.getDownloadURL();
      await saveImagePathToFirestore(path: url);
    }catch(e){
      print("=== === $e === ===");
    }
  }
  @override
  Future<void> saveImagePathToFirestore({required String path}) async{
    DocumentReference c = FirebaseFirestore.instance.collection("UsersInfo").doc(getCurrentUserId());
    try{
      await c.update({
        "image":path,
      });
    }catch(e){
      print("=== === $e === ===");
    }
  }
}
