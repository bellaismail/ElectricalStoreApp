import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/models/user_model.dart';
import 'package:store_app2/view_models/drawer_view_model.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 1.5),
        child: Drawer(
          backgroundColor: kBackgroundColor,
          shape: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
            borderSide: BorderSide.none,
          ),
          elevation: 10.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                HeaderDrawerWidget(),
                BodyDrawerWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DrawerHeader(
        child: Column(
          children: const [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSC3JJLb6CKEw283Ga_WnBvEHoGa19hApG-Bg&usqp=CAU",
              ),
            ),
            Text(
              "3m elanas",
            ),
            Text(
              "3m elanas@yahoo.com",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyDrawerWidget extends StatelessWidget {
  DrawerViewModel drawerViewModel = DrawerViewModel();

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> drawerRowList = drawerViewModel.drawerRowList;
    return Expanded(
      child: Column(
        children: [
          // BodyDrawerRowWidget(text: drawerRowList[0]["text"], icon: drawerRowList[0]["icon"]),
          // BodyDrawerRowWidget(text: drawerRowList[1]["text"], icon: drawerRowList[1]["icon"]),
          // BodyDrawerRowWidget(text: drawerRowList[2]["text"], icon: drawerRowList[2]["icon"]),
          // BodyDrawerRowWidget(text: drawerRowList[3]["text"], icon: drawerRowList[3]["icon"]),
          // BodyDrawerRowWidget(text: drawerRowList[4]["text"], icon: drawerRowList[4]["icon"]),
          // BodyDrawerRowWidget(text: drawerRowList[5]["text"], icon: drawerRowList[5]["icon"]),
          Expanded(
            child: ListView.builder(
              itemCount: drawerRowList.length,
              itemBuilder: (context, index) => BodyDrawerRowWidget(
                text: drawerRowList[index]["text"],
                icon: drawerRowList[index]["icon"],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BodyDrawerRowWidget extends StatelessWidget {
  final IconData? icon;
  final String? text;

  BodyDrawerRowWidget({this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            CollectionReference c =
                FirebaseFirestore.instance.collection("owner");
            try {
              UserModel user = UserModel(
                name: "Bilal Ashraf",
                email: "bellaismail629@gmail.com",
                image: "ImagePath",
              );
              await c.doc("123456789").set({
                "name": user.name,
                "email": user.email,
                "image": user.image,
              }).then((value) => Navigator.pop(context));
            } catch (e) {
              print("**************somethingWrong :$e//////////////");
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text!,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey,
                  ),
                ),
                Icon(
                  icon,
                  color: Colors.grey,
                  size: 25.0,
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
