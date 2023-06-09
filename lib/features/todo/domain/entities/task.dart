import 'package:hive/hive.dart';

import 'package:equatable/equatable.dart';

import '../../../../core/models/item.dart';

part 'task.g.dart';

@HiveType(typeId: 6)
class AppTask extends Item {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String? reminder;

  @HiveField(2)
  final String? tag;

  @HiveField(3)
  final String? description;

  @HiveField(4)
  final String id;

  @HiveField(5)
  final String? group;

  @HiveField(6)
  final String? color;

  @HiveField(7)
  final bool done;

  @HiveField(8)
  final String createdAt;

  @HiveField(9)
  final bool repeated;

  @HiveField(11)
  final List<int> repeatedDays;

  @HiveField(10)
  final List<String> doneDates;

  AppTask({
    this.repeated = false,
    this.color,
    this.reminder,
    required this.createdAt,
    required this.done,
    required this.title,
    this.tag,
    this.repeatedDays = const [],
    this.description,
    this.group,
    this.doneDates = const [],
    required this.id,
  });

  AppTask copyWith(
      {bool? done,
      String? createdAt,
      List<String>? doneDates,
      List<int>? repeatedDays}) {
    return AppTask(
      done: done ?? this.done,
      title: title,
      id: id,
      tag: tag,
      group: group,
      description: description,
      reminder: reminder,
      color: color,
      repeated: repeated,
      createdAt: createdAt ?? this.createdAt,
      doneDates: doneDates ?? this.doneDates,
      repeatedDays: repeatedDays ?? this.repeatedDays,
    );
  }

  @override
  List<Object?> get props => [
        id,
        doneDates,
        repeated,
        createdAt,
        repeatedDays,
        reminder,
        title,
        description,
        group,
        tag,
      ];
}
