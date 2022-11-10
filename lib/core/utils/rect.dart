import 'package:flutter/material.dart';

RectTween createRectTween(Rect? begin, Rect? end) {
  return MaterialRectCenterArcTween(begin: begin, end: end);
}
