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

extension SwappableList<E> on List<E> {
  void swap(int first, int second) {
    final temp = this[first];
    this[first] = this[second];
    this[second] = temp;
  }
}
