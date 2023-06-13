import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/note.dart';

abstract class NoteRemoteDataSource {
  Future<Unit> addNote({required Note note});
  Future<Unit> removeNote({required String noteId});
  Future<List<Note>> fetchNotes({String? folderName});
}

class NoteRemoteDataSourceImpl implements NoteRemoteDataSource {
  final FirebaseFirestore db;
  final FirebaseAuth auth;

  NoteRemoteDataSourceImpl({
    required this.db,
    required this.auth,
  });

  String? get userId => auth.currentUser?.uid;

  bool get isAuthed => auth.currentUser != null;

  @override
  Future<Unit> addNote({required Note note}) async {
    if (isAuthed) {
      print(isAuthed);
      print(userId);
      await db.collection("notes").doc(note.id).set(
            note.toFirebase(
              userId: userId!,
            ),
          );
    }

    return unit;
  }

  @override
  Future<List<Note>> fetchNotes({String? folderName}) async {
    List<Note> notes = [];

    if (isAuthed) {
      final noteMaps = (await db
              .collection("notes")
              .where("userId", isEqualTo: userId!)
              .where(
                "folderName",
                isEqualTo: folderName ?? "All",
              )
              .get())
          .docs;

      notes = noteMaps
          .map(
            (noteMap) => Note.fromFirebase(
              noteMap.data(),
              noteMap.id,
            ),
          )
          .toList();
    }

    return notes;
  }

  @override
  Future<Unit> removeNote({required String noteId}) async {
    if (isAuthed) {
      await db.collection("notes").doc(noteId).delete();
    }

    return unit;
  }
}
