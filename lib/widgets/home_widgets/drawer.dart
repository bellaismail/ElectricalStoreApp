import 'package:flutter/material.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/view_models/drawer_view_model.dart';

import '../../repositories/user_repositories/user_repo_firebase.dart';

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
          Expanded(
            child: ListView.builder(
              itemCount: drawerRowList.length,
              itemBuilder: (context, index) => BodyDrawerRowWidget(
                text: drawerRowList[index]["text"],
                icon: drawerRowList[index]["icon"],
                onTapFun: drawerRowList[index]["onTapFun"] == null ?null :drawerRowList[index]["onTapFun"],
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
  final Function()? onTapFun;

  BodyDrawerRowWidget({
    this.text,
    this.icon,
    this.onTapFun,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTapFun,
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
