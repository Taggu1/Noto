import 'package:flutter/material.dart';

class SheetTitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  const SheetTitleText({super.key, required this.text, this.fontSize = 16});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
