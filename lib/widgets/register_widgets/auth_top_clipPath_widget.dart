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
              alignment: Alignment.centerRight,
            ),
            painter: _Painter(),
          ),
        ),
        Positioned(
          top: 30,
          right: 0,
          child: CustomPaint(
            child: Container(
              alignment: Alignment.centerRight,
              height: 80,
              width: 150,
              child: Padding(
                padding: const EdgeInsets.only(right:  kDefaultPadding / 2, top: 10.0),
                child: Text(
                  text,
                  style: const TextStyle(
                      color: kBackgroundColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            painter: _Painter3(),
          ),
        ),
      ],
    );
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

class _Painter3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path _path = Path();
    double w = size.width;
    double h = size.height;

    _path
    ..moveTo(w , h)
    ..lineTo(w -200, h )
    ..lineTo(w - 160, h / 1.6)
    ..lineTo(w -200, h / 3.7)
    ..lineTo(w , h / 3.5)
    ..close();


    Paint paint = Paint()..color = Colors.redAccent;
    canvas.drawPath(_path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


