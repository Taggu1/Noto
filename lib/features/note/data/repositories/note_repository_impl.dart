import 'package:note_app/core/data_sources/local_data_source.dart';
import 'package:note_app/core/errors/exceptions.dart';
import 'package:note_app/features/note/data/data_sources/note_local_data_source.dart';
import 'package:note_app/features/note/data/data_sources/note_remote_data_source.dart';
import 'package:note_app/features/note/domain/entities/note.dart';
import 'package:note_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:note_app/features/note/domain/repositories/note_repository.dart';

class NoteRepositoryImpl implements NotesRepository {
  final NoteLocalDataSource noteLocalDataSource;
  final LocalDataSource<Note> localDataSourceImpl;
  final NoteRemoteDataSource noteRemoteDataSource;

  NoteRepositoryImpl({
    required this.noteLocalDataSource,
    required this.localDataSourceImpl,
    required this.noteRemoteDataSource,
  });
  @override
  Future<Either<Failure, List<Note>>> fetchNotes({String? folderName}) async {
    try {
      var notes = await localDataSourceImpl.fetchItems();

      if (folderName != null && folderName != "All") {
        notes = notes
            .where(
              (note) => note.folderName == folderName,
            )
            .toList();
      }

      return Right(
        notes
          ..sort(
            (a, b) => a.index.compareTo(
              b.index,
            ),
          ),
      );
    } on DatabaseException {
      return Left(
        DatabaseFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> removeNote({required String noteId}) async {
    try {
      final response = await localDataSourceImpl.removeItem(itemId: noteId);

      await noteRemoteDataSource.removeNote(noteId: noteId);
      return Right(response);
    } on DatabaseException {
      print('WHATTHEFUCK');
      return Left(
        DatabaseFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> addOrEditNote({required Note note}) async {
    try {
      Unit response;

      response = await localDataSourceImpl.addItem(item: note);
      await noteRemoteDataSource.addNote(
        note: note,
      );

      return Right(response);
    } on DatabaseException {
      return Left(
        DatabaseFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> reOrderNotes(
      {required List<Note> notes}) async {
    try {
      final response = await noteLocalDataSource.reOrderNotes(notes: notes);
      return Right(response);
    } on DatabaseException {
      return Left(
        DatabaseFailure(),
      );
    }
  }

  @override
  Future<void> syncNotes() async {
    final localNotes = await localDataSourceImpl.fetchItems();

    final remoteNotes = await noteRemoteDataSource.fetchNotes();
    // int index = remoteNotes.length;

    // for (final note in localNotes) {
    //   if (note.drawing == null && !remoteNotes.contains(note)) {
    //     print("Local $note");
    //     await noteRemoteDataSource.addNote(
    //       note: note.copyWith(index: index),
    //     );
    //   }
    //   index++;
    // }

    for (final note in remoteNotes) {
      print("Remote $note");
      if (note.drawing == null && !localNotes.contains(note)) {
        await localDataSourceImpl.addItem(
          item: note,
        );
      }
    }
  }
}
