import 'package:note_app/core/data_sources/local_data_source.dart';
import 'package:note_app/core/errors/exceptions.dart';
import 'package:note_app/features/note/data/data_sources/note_local_data_source.dart';
import 'package:note_app/features/note/domain/entities/note.dart';
import 'package:note_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:note_app/features/note/domain/repositories/note_repository.dart';

class NoteRepositoryImpl implements NotesRepository {
  final NoteLocalDataSource noteLocalDataSource;
  final LocalDataSource<Note> localDataSourceImpl;

  NoteRepositoryImpl({
    required this.noteLocalDataSource,
    required this.localDataSourceImpl,
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

      return Right(response);
    } on DatabaseException {
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
}
