// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteAdapter extends TypeAdapter<Note> {
  @override
  final int typeId = 0;

  @override
  Note read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Note(
      folderName: fields[9] as String?,
      index: fields[8] as int,
      title: fields[0] as String?,
      body: fields[1] as String?,
      id: fields[2] as String,
      time: fields[3] as String?,
      color: fields[4] as String?,
      drawing: fields[5] as Uint8List?,
      points: (fields[6] as Map?)?.map((dynamic k, dynamic v) =>
          MapEntry(k as HiveOffset, (v as Map).cast<String, dynamic>())),
      externalImagePath: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Note obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.body)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.drawing)
      ..writeByte(6)
      ..write(obj.points)
      ..writeByte(7)
      ..write(obj.externalImagePath)
      ..writeByte(8)
      ..write(obj.index)
      ..writeByte(9)
      ..write(obj.folderName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
