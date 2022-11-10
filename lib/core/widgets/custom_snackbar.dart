import 'package:flutter/material.dart';

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
    content: Text(
      content,
      textAlign: TextAlign.center,
    ),
  );
}
