import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:real_estate/constants/colors.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: MediaQuery.of(context).size, painter: GradientPainter());
  }
}

class GradientPainter extends CustomPainter {
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
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}