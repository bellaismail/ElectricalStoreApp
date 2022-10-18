import 'package:flutter/material.dart';
import 'package:store_app2/constant.dart';

SnackBar snackBarWidget(String text, {Color? color}) {
  return SnackBar(
    content: Text(
      text,
      style: const TextStyle(
        color: kBackgroundColor,
      ),
    ),
    backgroundColor: color,
  );
}
