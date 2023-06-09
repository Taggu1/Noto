import 'package:flutter/material.dart';

ScaffoldFeatureController showAppDefultSnackbar(
    BuildContext context, String messeage) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      backgroundColor: Theme.of(context).primaryColor,
      content: Text(
        messeage,
        textAlign: TextAlign.center,
      ),
    ),
  );
}
