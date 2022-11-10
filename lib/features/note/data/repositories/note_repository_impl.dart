import 'package:note_app/core/errors/exceptions.dart';
import 'package:note_app/features/note/data/data_sources/local_data_source.dart';
import 'package:note_app/features/note/domain/entities/note.dart';
import 'package:note_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:note_app/features/note/domain/repositories/note_repository.dart';

enum NoteFunctionType {
  add,
  edit,
}

class NoteRepositoryImpl implements NotesRepository {
  final NoteLocalDataSource localDataSource;

  NoteRepositoryImpl({required this.localDataSource});
  @override
  @override
  Future<Either<Failure, List<Note>>> fetchNotes() async {
    try {
      final notes = await localDataSource.fetchNotes();
      return Right(notes);
    } on DatabaseException {
      return Left(
        DatabaseFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> removeNote({required int noteIndex}) async {
    try {
      final response = await localDataSource.removeNote(index: noteIndex);
      return Right(response);
    } on DatabaseException {
      return Left(
        DatabaseFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> addOrEditNote(
      {required Note note,
      required NoteFunctionType funcType,
      int? index}) async {
    try {
      Unit response;
      switch (funcType) {
        case NoteFunctionType.edit:
          response = await localDataSource.editNote(note: note, index: index!);
          break;
        default:
          response = await localDataSource.addNote(note: note);
          break;
      }
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
      final response = await localDataSource.reOrderNotes(notes: notes);
      return Right(response);
    } on DatabaseException {
      return Left(
        DatabaseFailure(),
      );
    }
  }
}
