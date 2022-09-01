import 'package:dartz/dartz.dart';
import 'package:note_app/features/note/domain/repositories/note_repository.dart';

import '../../../../core/errors/failures.dart';

class RemoveNoteUseCase {
  final NotesRepository repository;

  RemoveNoteUseCase({required this.repository});

  Future<Either<Failure, Unit>> call({required int noteIndex}) async {
    return await repository.removeNote(noteIndex: noteIndex);
  }
}
