import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class AuthTopClipPathWidget extends StatelessWidget {
  AuthTopClipPathWidget({required this.text});

  String text;

  @override
  Widget build(BuildContext context) {
    var orient = MediaQuery.of(context).orientation;

    return Stack(
      children: [
        Opacity(
          opacity: .3,
          child: CustomPaint(
            child: Container(
              height: orient == Orientation.portrait? 340: 240,
              alignment: Alignment.center,
            ),
            painter: _Painter2(),
          ),
        ),
        Opacity(
          opacity: .8,
          child: CustomPaint(
            child: Container(
              height: orient == Orientation.portrait? 300: 200,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom:  kDefaultPadding),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: kBackgroundColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        offset: Offset(5, 0),
                        blurRadius: 2,
                      ),
                    ]
                  ),
                ),
              ),
            ),
            painter: _Painter(),
          ),
        ),
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

class _Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path _path = Path();
    double w = size.width;
    double h = size.height;

    _path
      ..moveTo(0, 0)
      ..lineTo(0, h / 1.5)
      ..quadraticBezierTo(w / 2, h, w, h / 1.5)
      ..lineTo(w, 0)
      ..close();

    Paint paint = Paint()..color = kTextColor;

    Paint circlePaint1 = Paint()..color = Colors.indigoAccent.withOpacity(0.7);
    Offset circleCenter1 = Offset(w / 3, h / 2.2);
    Paint circlePaint2 = Paint()..color = Colors.lightGreen.withOpacity(0.7);
    Offset circleCenter2 = Offset(w / 1.5, h / 3);
    Paint circlePaint3 = Paint()..color = Colors.green.withOpacity(0.5);
    Offset circleCenter3 = Offset(w - 70, h / 1.8);
    Paint circlePaint4 = Paint()..color = Colors.redAccent.withOpacity(0.5);
    Offset circleCenter4 = Offset(w / 6, h / 5);
    Paint circlePaint5 = Paint()..color = Colors.grey.withOpacity(0.5);
    Offset circleCenter5 = Offset(w / 6, h / 1.5);
    Paint circlePaint6 = Paint()..color = Colors.grey.withOpacity(0.5);
    Offset circleCenter6 = Offset(w / 1.1, h / 5);
    Paint circlePaint7 = Paint()..color = Colors.grey.withOpacity(0.5);
    Offset circleCenter7 = Offset(w / 2, h / 1.3);


    canvas.drawPath(_path, paint);

    canvas.drawCircle(circleCenter1, 50, circlePaint1);
    canvas.drawCircle(circleCenter2, 25, circlePaint2);
    canvas.drawCircle(circleCenter3, 40, circlePaint3);
    canvas.drawCircle(circleCenter4, 35, circlePaint4);
    canvas.drawCircle(circleCenter5, 15, circlePaint5);
    canvas.drawCircle(circleCenter6, 15, circlePaint6);
    canvas.drawCircle(circleCenter7, 10, circlePaint7);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _Painter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path _path = Path();
    double w = size.width;
    double h = size.height;

    _path
      ..moveTo(0, 0)
      ..lineTo(0, h / 1.5)
      ..quadraticBezierTo(w / 2, h - 20, w, h / 1.5)
      ..lineTo(w, 0)
      ..close();

    // canvas.clipPath(_path);
    Paint paint = Paint()..color = kTextColor;


    canvas.drawPath(_path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


