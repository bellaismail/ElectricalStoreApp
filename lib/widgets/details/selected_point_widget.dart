import 'package:flutter/material.dart';

class ChoosePointWidget extends StatelessWidget {
  ChoosePointWidget({
    this.pointColor,
    this.isSelected,
  });

  final Color? pointColor;
  bool? isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.0,
      height: 24.0,
      padding: const EdgeInsets.all(2.0),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: !isSelected! ?Colors.transparent :pointColor!),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: pointColor!,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}