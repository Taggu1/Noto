// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemeAdapter extends TypeAdapter<Theme> {
  @override
  final int typeId = 11;

  @override
  Theme read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Theme(
      isDarkMode: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Theme obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isDarkMode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
