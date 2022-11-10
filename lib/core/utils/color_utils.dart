import "dart:math";

import 'package:flutter/material.dart';

import '../constants/colors.dart';

Color getRandomColor() {
  final random = Random();

  return noteCollors[random.nextInt(noteCollors.length)];
}
