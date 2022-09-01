import 'package:dartz/dartz.dart';
import 'package:note_app/features/note/data/repositories/note_repository_impl.dart';
import 'package:note_app/features/note/domain/repositories/note_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entities/note.dart';

class AddOrEditNoteUseCase {
  final NotesRepository repository;

  AddOrEditNoteUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(
      {required Note note, required FunType addOrEdit, int? index}) async {
    return await repository.addOrEditNote(
        note: note, funcType: addOrEdit, index: index);
  }
}
