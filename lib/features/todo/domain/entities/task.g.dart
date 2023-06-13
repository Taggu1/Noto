// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppTaskAdapter extends TypeAdapter<AppTask> {
  @override
  final int typeId = 6;

  @override
  AppTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppTask(
      repeated: fields[9] as bool,
      color: fields[6] as String?,
      reminder: fields[1] as String?,
      createdAt: fields[8] as String,
      title: fields[0] as String,
      tag: fields[2] as String?,
      repeatedDays: (fields[11] as List).cast<int>(),
      description: fields[3] as String?,
      group: fields[5] as String?,
      doneDates: (fields[10] as List).cast<String>(),
      id: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AppTask obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.reminder)
      ..writeByte(2)
      ..write(obj.tag)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.group)
      ..writeByte(6)
      ..write(obj.color)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.repeated)
      ..writeByte(11)
      ..write(obj.repeatedDays)
      ..writeByte(10)
      ..write(obj.doneDates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
