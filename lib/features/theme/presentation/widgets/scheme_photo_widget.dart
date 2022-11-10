import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SchemePhotoWidget extends StatelessWidget {
  final int themeNum;
  final bool isDark;
  const SchemePhotoWidget(
      {super.key, required this.themeNum, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final prefix = isDark ? "_dark" : "_light";
    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: constraints.maxWidth * 0.48,
              child: Image.asset(
                "assets/images/sm$themeNum$prefix.jpg",
                fit: BoxFit.fitHeight,
              ),
            ),
            Image.asset(
              width: constraints.maxWidth * 0.48,
              "assets/images/sd${themeNum}${prefix}.jpg",
            ),
          ],
        );
      },
    );
  }
}
