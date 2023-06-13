import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:note_app/core/models/hive_offset.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends Equatable with HiveObjectMixin {
  @HiveField(0)
  final String? title;

  @HiveField(1)
  final String? body;

  @HiveField(2)
  final String id;

  @HiveField(3)
  final String? time;

  @HiveField(4)
  final String? color;

  @HiveField(5)
  final Uint8List? drawing;

  @HiveField(6)
  final Map<HiveOffset, Map<String, dynamic>>? points;

  @HiveField(7)
  final String? externalImagePath;

  @HiveField(8)
  final int index;

  @HiveField(9)
  final String? folderName;

  Note({
    this.folderName,
    required this.index,
    required this.title,
    required this.body,
    required this.id,
    required this.time,
    required this.color,
    this.drawing,
    this.points,
    this.externalImagePath,
  });

  @override
  List<Object?> get props => [
        title,
        body,
        id,
        time,
        color,
        drawing,
        points,
        externalImagePath,
        index,
        folderName,
      ];

  Note copyWith({int? index, String? folderName}) {
    return Note(
      index: index ?? this.index,
      title: title,
      body: body,
      id: id,
      time: time,
      color: color,
      externalImagePath: externalImagePath,
      folderName: folderName ?? this.folderName,
    );
  }

  Map<String, dynamic> toFirebase({required String userId}) {
    return {
      "userId": userId,
      "color": color,
      "index": index,
      if (folderName != null) "folderName": folderName,
      if (time != null) "time": time,
      if (title != null) "title": title,
      if (body != null) "body": body,
    };
  }

  factory Note.fromFirebase(Map<String, dynamic> json, final String id) {
    return Note(
      index: json["index"],
      title: json["title"],
      body: json["body"],
      id: id,
      time: json["time"],
      color: json["color"],
      drawing: json["drawing"],
      folderName: json["folderName"],
      points: json["points"],
    );
  }
}
