import 'package:dartz/dartz.dart';
import 'package:note_app/features/note/domain/repositories/note_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entities/note.dart';

class FetchNotesUseCase {
  final NotesRepository repository;

  FetchNotesUseCase({required this.repository});

  Future<Either<Failure, List<Note>>> call() async {
    return await repository.fetchNotes();
  }
}
