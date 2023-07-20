import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/note.dart';

abstract class NotesRepository {
  Future<Either<Failure, List<Note>>> fetchNotes({String? folderName});
  Future<Either<Failure, Unit>> addOrEditNote({required Note note});
  Future<Either<Failure, Unit>> removeNote({required String noteId});
  Future<Either<Failure, Unit>> reOrderNotes({required List<Note> notes});
}
