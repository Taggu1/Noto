import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringFuncs on String {
  Color toMaterialColor() {
    String valueString = split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    return Color(value);
  }

  String toFormatedDate() {
    return DateFormat.yMMMd().format(DateTime.parse(this));
  }
}
