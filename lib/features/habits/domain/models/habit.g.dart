// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitAdapter extends TypeAdapter<Habit> {
  @override
  final int typeId = 13;

  @override
  Habit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Habit(
      time: fields[5] as String,
      createdAt: fields[0] as String,
      doneDates: (fields[1] as List).cast<String>(),
      name: fields[2] as String,
      color: fields[3] as String,
      habitDays: (fields[6] as List).cast<int>(),
      id: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Habit obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.createdAt)
      ..writeByte(1)
      ..write(obj.doneDates)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.time)
      ..writeByte(6)
      ..write(obj.habitDays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
