import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constants/theme_constants.dart';

SnackBar customSnackBar({required String content}) {
  return SnackBar(
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    ),
    backgroundColor: kGreyColor,
    content: Text(
      content,
      style: const TextStyle(
        color: kWhiteColor,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
