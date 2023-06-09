import 'package:dartz/dartz.dart';
import 'package:note_app/features/note/domain/repositories/note_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entities/note.dart';

class AddOrEditNoteUseCase {
  final NotesRepository repository;

  AddOrEditNoteUseCase({required this.repository});

  Future<Either<Failure, Unit>> call({required Note note}) async {
    return await repository.addOrEditNote(note: note);
  }
}
