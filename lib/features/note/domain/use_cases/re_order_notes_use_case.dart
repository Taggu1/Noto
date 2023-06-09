import 'package:dartz/dartz.dart';
import 'package:note_app/features/note/domain/repositories/note_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entities/note.dart';

class ReOrderNotesUseCase {
  final NotesRepository repository;

  const ReOrderNotesUseCase({required this.repository});

  Future<Either<Failure, Unit>> call({required List<Note> notes}) async {
    return await repository.reOrderNotes(notes: notes);
  }
}
