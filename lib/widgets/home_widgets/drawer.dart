import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/repositories/user_repositories/user_repo_firebase.dart';
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

class HeaderDrawerWidget extends StatefulWidget {
  @override
  State<HeaderDrawerWidget> createState() => _HeaderDrawerWidgetState();
}

class _HeaderDrawerWidgetState extends State<HeaderDrawerWidget> {

  @override
  void initState() {
    Provider.of<DrawerViewModel>(context, listen: false).getUserData(userRepository: UserRepoFirebase());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DrawerViewModel>(context);
    return SizedBox(
      width: double.infinity,
      child: DrawerHeader(
        child: provider.userViewModel == null
            ? const Center(child: CircularProgressIndicator(),)
            : Column(
          children: [
            CircleAvatar(
              radius: 50,
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(top: 50),
                width: double.infinity - 50,
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(75.0),
                    bottomRight: Radius.circular(75.0),
                  ),
                ),
              ),
              backgroundImage: provider.profileImage(userViewModel: provider.userViewModel!),
            ),
            Text(
              "${provider.userViewModel!.name}",
            ),
            Text(
              "${provider.userViewModel!.email}",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyDrawerWidget extends StatelessWidget {
  DrawerViewModel drawerViewModel = DrawerViewModel(userRepository: UserRepoFirebase());
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> drawerRowList = drawerViewModel.drawerRowList;
    var provider = Provider.of<DrawerViewModel>(context);
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: drawerRowList.length,
              itemBuilder: (context, index) => BodyDrawerRowWidget(
                text: drawerRowList[index]["text"],
                icon: drawerRowList[index]["icon"],
                onTapFun: drawerRowList[index]["onTapFun"],
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