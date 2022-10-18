import 'package:flutter/material.dart';

class SocialLoginIconWidget extends StatelessWidget {
  SocialLoginIconWidget({
    this.imagePath,
    this.onTapFun,
  });

  final String? imagePath;
  final Function()? onTapFun;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFun,
      child: Card(
        elevation: 15.0,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide.none,
        ),
        child: CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage("$imagePath"),
        ),
      ),
    );
  }
}
