import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'habit.g.dart';

@HiveType(typeId: 13)
class Habit extends Equatable {
  @HiveField(0)
  final String createdAt;

  @HiveField(1)
  final List<String> doneDates;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String color;

  @HiveField(4)
  final String id;

  @HiveField(5)
  final String time;

  @HiveField(6)
  final List<int> habitDays;

  const Habit({
    required this.time,
    required this.createdAt,
    required this.doneDates,
    required this.name,
    required this.color,
    required this.habitDays,
    required this.id,
  });

  Habit copyWith({List<String>? doneDates}) {
    return Habit(
      time: time,
      createdAt: createdAt,
      doneDates: doneDates ?? this.doneDates,
      name: name,
      color: color,
      habitDays: habitDays,
      id: id,
    );
  }

  @override
  List<Object?> get props => [
        createdAt,
        doneDates,
        name,
        color,
      ];
}
