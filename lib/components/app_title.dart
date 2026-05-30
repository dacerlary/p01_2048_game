import 'package:flutter/material.dart';

import '../const/colors.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key, required this.text, this.fontSize = 52});

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.skewX(-0.08),
      alignment: Alignment.center,
      child: Stack(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w900,
              letterSpacing: 0,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 5
                ..color = colorApp.score,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: colorApp.accent,
              fontSize: fontSize,
              fontWeight: FontWeight.w900,
              letterSpacing: 0,
              shadows: [
                Shadow(
                  color: colorApp.button.withValues(alpha: 0.55),
                  blurRadius: 0,
                  offset: const Offset(3, 3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
