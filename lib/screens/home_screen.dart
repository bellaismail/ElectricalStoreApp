import 'package:flutter/material.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/widgets/home_widgets/drawer.dart';
import 'package:store_app2/widgets/home_widgets/home_body_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: homeAppBar(),
      body: HomeBodyWidget(),
      endDrawer: const DrawerWidget(),
    );
  }
  AppBar homeAppBar(){
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0.0,
      title: const Text("مرحبا بكم بمتجر الالكترونيات"),
    );
  }
}
