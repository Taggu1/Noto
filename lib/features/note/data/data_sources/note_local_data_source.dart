import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:note_app/core/errors/exceptions.dart';
import 'package:note_app/features/note/domain/entities/note.dart';

abstract class NoteLocalDataSource {
  Future<Unit> reOrderNotes({required List<Note> notes});
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  Box<Note> hiveBox;

  NoteLocalDataSourceImpl({required this.hiveBox});

  @override
  Future<Unit> reOrderNotes({required List<Note> notes}) async {
    try {
      await hiveBox.clear();
      await hiveBox.addAll(notes);

      return Future.value(unit);
    } catch (e) {
      throw DatabaseException();
    }
  }
}
