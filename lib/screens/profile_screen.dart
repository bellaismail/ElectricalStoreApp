import 'package:flutter/material.dart';
import 'package:store_app2/constant.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: appBar(),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: kDefaultPadding * 7,
              left: kDefaultPadding / 2,
              right: kDefaultPadding / 2,
            ),
            decoration: const BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              )
            ),
          ),
          Positioned(
            top: 82.0,
            child: Card(
              elevation: 20,
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(80.0),
                borderSide: BorderSide.none,
              ),
              child: const CircleAvatar(
                radius: 70.0,
                backgroundColor: kBackgroundColor,
                backgroundImage: AssetImage("images/ele3.jpg"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0.0,
      title: const Text('حسابك'),
    );
  }
}
