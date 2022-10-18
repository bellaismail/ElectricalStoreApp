import 'package:flutter/material.dart';

import '../../constant.dart';

class AuthTopClipPathWidget extends StatelessWidget {
  AuthTopClipPathWidget({required this.text});

  String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: .5,
          child: ClipPath(
            child: Container(
              height: 200,
              color: kBlueColor.withOpacity(.5),
            ),
            clipper: _MoveClipper(),
          ),
        ),
        ClipPath(
          child: Container(
            height: 170,
            color: kPrimaryColor,
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: kDefaultPadding,
                right: 5,
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: kBackgroundColor,
                  fontSize: 22,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(2, 0),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          clipper: _MoveClipper(),
        ),
        // Container(
        //   width: double.infinity,
        //   height: 200,
        //   color: Colors.green,
        // )
      ],
    );
  }
}

class _MoveClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;

    // path.moveTo(0, h);
    path
      ..lineTo(0, h - 30)
      ..quadraticBezierTo(w / 4, h - 60, w * .75, h - 10)
      ..quadraticBezierTo(w * .85, h, w, h - 10)
      ..lineTo(w, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
