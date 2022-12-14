import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app/features/note/data/data_sources/local_data_source.dart';
import 'package:note_app/features/note/data/repositories/note_repository_impl.dart';
import 'package:note_app/features/note/domain/use_cases/add_note_use_case.dart';
import 'package:note_app/features/note/domain/use_cases/fetch_notes_use_case.dart';
import 'package:note_app/features/note/domain/use_cases/re_order_notes_use_case.dart';
import 'package:note_app/features/note/domain/use_cases/remove_note_use_case.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/note.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final FetchNotesUseCase fetchNotesUseCase;
  final RemoveNoteUseCase removeNoteUseCase;
  final AddOrEditNoteUseCase addOrEditNoteUseCase;
  final ReOrderNotesUseCase reOrderNotesUseCase;
  NoteBloc({
    required this.fetchNotesUseCase,
    required this.removeNoteUseCase,
    required this.addOrEditNoteUseCase,
    required this.reOrderNotesUseCase,
  }) : super(NoteInitial()) {
    on<NoteEvent>(
      (event, emit) async {
        if (event is FetchNotesEvent) {
          emit(LoadingNotesState());
          final notesOrFailure = await fetchNotesUseCase();

          emit(_notesOrFailureToNoteState(notesOrFailure));
        } else if (event is EditOrAddNoteEvent) {
          await addOrEditNoteUseCase(
            note: event.note,
            addOrEdit: event.addOrEdit,
            index: event.index,
          );
          final notesOrFailure = await fetchNotesUseCase();
          emit(_notesOrFailureToNoteState(notesOrFailure));
        } else if (event is ReOrderNotesEvent) {
          reOrderNotesUseCase(notes: event.notes);
        } else if (event is RemoveNoteEvent) {
          await removeNoteUseCase(noteIndex: event.noteIndex);
        } else if (event is SearchNoteEvent) {
          final notesOrFailure = await fetchNotesUseCase();
          notesOrFailure.fold(
            (failure) => null,
            (notes) {
              final searchedNotes = notes
                  .where(
                    (note) => note.title!
                        .toLowerCase()
                        .contains(event.searchText.toLowerCase()),
                  )
                  .toList();
              emit(
                searchedNotes.isNotEmpty
                    ? LoadedNoteState(notes: searchedNotes)
                    : const NoteWasNotFoundState(message: "Note was not Found"),
              );
            },
          );
        }
      },
    );
  }

  NoteState _notesOrFailureToNoteState(
      Either<Failure, List<Note>> notesOrFailure) {
    return notesOrFailure.fold(
      (failure) => const ErrorNotesState(message: "TestMessage"),
      (notes) => LoadedNoteState(notes: notes),
    );
  }
}
