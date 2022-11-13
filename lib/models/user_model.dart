import 'dart:convert';

import 'image_model.dart';

class UserModel {
  String? name;
  String? email;
  String? image;
  String? password;
  String? currentUserId;

  UserModel({
    this.name,
    this.email,
    this.image,
    this.password,
    this.currentUserId,
  });

  UserModel.fromJSON(Map<String, dynamic> json){
    name = json["name"];
    email = json["email"];
    image = json["image"];
    password = json["image"];
    currentUserId = json["currentUserId"];
  }

  Map<String, dynamic> toJSON(){
    return {
      "name": name,
      "email": email,
      "image": image,
      "password": password,
      "currentUserId": currentUserId,
    };
  }
}
