import "dart:math";

import 'package:flutter/material.dart';

import '../constants/colors.dart';

Color getRandomColor() {
  final random = Random();

  return designColors[random.nextInt(designColors.length)];
}
