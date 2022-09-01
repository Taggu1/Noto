import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends Equatable with HiveObjectMixin {
  @HiveField(0)
  final String? title;

  @HiveField(1)
  final String? body;

  @HiveField(2)
  final String? id;

  @HiveField(3)
  final String? time;

  @HiveField(4)
  final String? color;

  @HiveField(5)
  final Uint8List? drawing;

  Note({
    required this.title,
    required this.body,
    required this.id,
    required this.time,
    required this.color,
    this.drawing
  });

  @override
  List<Object?> get props => [title, body, id, time, color];
}
