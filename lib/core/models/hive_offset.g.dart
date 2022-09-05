// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_offset.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveOffsetAdapter extends TypeAdapter<HiveOffset> {
  @override
  final int typeId = 1;

  @override
  HiveOffset read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveOffset(
      fields[0] as double,
      fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, HiveOffset obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.dx)
      ..writeByte(1)
      ..write(obj.dy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveOffsetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
