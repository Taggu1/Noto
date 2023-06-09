import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants/theme_constants.dart';

class NoDataWidget extends StatelessWidget {
  final String text;
  final String animationUrl;
  const NoDataWidget({
    super.key,
    required this.text,
    required this.animationUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: titleTextStyle,
        ),
        Lottie.asset(
          animationUrl,
          fit: BoxFit.contain,
          height: 330,
        ),
      ],
    );
  }
}
