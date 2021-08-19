import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:real_estate/constants/colors.dart';

class ProfileBackground extends StatelessWidget {
  const ProfileBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
            size: MediaQuery.of(context).size, painter: ProfilePainter1()),
        CustomPaint(
            size: MediaQuery.of(context).size, painter: ProfilePainter2())
      ],
    );
  }
}

class ProfilePainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
        const Offset(0, 0),
        Offset(size.width * .5, size.height * .5),
        [AppColors.primaryColor, AppColors.primaryColor.withOpacity(0.3)],
      );

    final path = Path()
      ..moveTo(size.width, size.height * 0.25)
      ..quadraticBezierTo(
        size.width * .5,
        size.height * .35,
        size.width * .5,
        size.height * .5,
      )
      ..quadraticBezierTo(
        size.width * .5,
        size.height * .65,
        0,
        size.height * 0.75,
      )
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.3)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ProfilePainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryColor.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * 0.75)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height * 0.25)
      ..quadraticBezierTo(
        size.width * .5,
        size.height * .35,
        size.width * .5,
        size.height * .5,
      )
      ..quadraticBezierTo(
        size.width * .5,
        size.height * .65,
        0,
        size.height * 0.75,
      )
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
