import 'package:flutter/material.dart';

class OutlinedGameText extends StatelessWidget {
  final String text;
  final double fontSize;
  final double strokeWidth;
  final Color fillColor;
  final Color strokeColor;
  final FontWeight fontWeight;
  final String fontFamily;
  final double letterSpacing;
  final TextAlign textAlign;

  const OutlinedGameText({
    super.key,
    required this.text,
    this.fontSize = 48,
    this.strokeWidth = 6,
    this.fillColor = Colors.orange,
    this.strokeColor = Colors.white,
    this.fontWeight = FontWeight.w900,
    this.fontFamily = 'Game',
    this.letterSpacing = 2,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: fontFamily,
            letterSpacing: letterSpacing,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),

        Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: fontFamily,
            letterSpacing: letterSpacing,
            color: fillColor,
          ),
        ),
      ],
    );
  }
}
