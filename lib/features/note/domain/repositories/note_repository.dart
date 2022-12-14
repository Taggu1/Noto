import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/repositories/note_repository_impl.dart';
import '../entities/note.dart';

abstract class NotesRepository {
  Future<Either<Failure, List<Note>>> fetchNotes();
  Future<Either<Failure, Unit>> addOrEditNote(
      {required Note note, required NoteFunctionType funcType, int? index});
  Future<Either<Failure, Unit>> removeNote({required int noteIndex});
  Future<Either<Failure, Unit>> reOrderNotes({required List<Note> notes});
}
