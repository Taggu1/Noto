import "dart:math";

import 'package:flutter/material.dart';

import '../constants/colors.dart';

Color getRandomColor() {
  final _random = new Random();

  return noteCollors[_random.nextInt(noteCollors.length)];
}
