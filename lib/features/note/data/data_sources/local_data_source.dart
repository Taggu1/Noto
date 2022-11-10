import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:note_app/core/errors/exceptions.dart';
import 'package:note_app/features/note/domain/entities/note.dart';

abstract class NoteLocalDataSource {
  Future<List<Note>> fetchNotes();
  Future<Unit> editNote({required Note note, required int index});
  Future<Unit> removeNote({required int index});
  Future<Unit> addNote({required Note note});
  Future<Unit> reOrderNotes({required List<Note> notes});
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  Box<Note> hiveBox;

  NoteLocalDataSourceImpl({required this.hiveBox});
  @override
  Future<Unit> addNote({required Note note}) {
    try {
      hiveBox.add(note);
      return Future.value(unit);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<Unit> editNote({required Note note, required int index}) {
    try {
      hiveBox.putAt(index, note);
      return Future.value(unit);
    } catch (e) {
      throw DatabaseException();
    }
  }

  @override
  Future<List<Note>> fetchNotes() async {
    if (!hiveBox.isOpen) {
      hiveBox = await Hive.openBox("notes");
    }
    try {
      return Future.value(
          hiveBox.values.where((element) => element.id != null).toList());
    } catch (e) {
      print(e);
      throw DatabaseException();
    }
  }

  @override
  Future<Unit> removeNote({required int index}) {
    try {
      hiveBox.deleteAt(index);
      return Future.value(unit);
    } catch (e) {
      throw DatabaseException();
    }
  }

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
