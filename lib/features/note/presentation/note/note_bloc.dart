import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
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
          final notesOrFailure =
              await fetchNotesUseCase(folderName: event.folderName);

          emit(_notesOrFailureToNoteState(notesOrFailure));
        } else if (event is EditOrAddNoteEvent && state is LoadedNoteState) {
          final currentState = state as LoadedNoteState;
          final unitOrFailure = await addOrEditNoteUseCase(
            note: event.note,
          );

          emit(
            _unitOrFailureToNoteState(
                unitOrFailure, event.note, currentState.notes),
          );
        } else if (event is ReOrderNotesEvent && state is LoadedNoteState) {
          await addOrEditNoteUseCase(
              note: event.draggedNote.copyWith(
            index: event.targetNote.index,
          ));

          await addOrEditNoteUseCase(
              note: event.targetNote.copyWith(
            index: event.draggedNote.index,
          ));
        } else if (event is RemoveNoteEvent && state is LoadedNoteState) {
          final currentState = state as LoadedNoteState;
          await removeNoteUseCase(noteId: event.noteId);

          emit(
            LoadedNoteState(
              notes: currentState.notes,
            ),
          );
        } else if (event is RemoveNotesEvent) {
          // ignore: avoid_function_literals_in_foreach_calls
          emit(LoadingNotesState());
          event.idsList.forEach((id) async {
            await removeNoteUseCase(
              noteId: id,
            );
          });
        } else if (event is SearchNoteEvent) {
          final notesOrFailure = await fetchNotesUseCase(
            folderName: event.currentFolderName,
          );

          notesOrFailure.fold(
            (failure) {
              return null;
            },
            (notes) {
              if (event.searchText.isEmpty) {
                emit(LoadedNoteState(notes: notes));
              } else {
                final searchedNotes = notes
                    .where(
                      (note) => note.title!
                          .toLowerCase()
                          .contains(event.searchText.toLowerCase().trim()),
                    )
                    .toList();
                emit(
                  searchedNotes.isNotEmpty
                      ? LoadedNoteState(notes: searchedNotes)
                      : const NoteWasNotFoundState(
                          message: "Note was not Found",
                        ),
                );
              }
            },
          );
        } else if (event is RemoveOrRenameFolderNotes) {
          final notes = _notesOrFailureToNotesList(await fetchNotesUseCase());

          final folderNotes = notes.where(
            (note) => note.folderName == event.oldFolderName,
          );

          for (final note in folderNotes) {
            if (event.isRemove) {
              await removeNoteUseCase(noteId: note.id);
            } else {
              await addOrEditNoteUseCase(
                note: note.copyWith(
                  folderName: event.newFolderName,
                ),
              );
            }
          }
        }
      },
    );
  }

  NoteState _notesOrFailureToNoteState(
      Either<Failure, List<Note>> notesOrFailure) {
    return notesOrFailure.fold(
      (failure) => const ErrorNotesState(
          message: "Something happened while loading the notes"),
      (notes) => LoadedNoteState(notes: notes),
    );
  }

  List<Note> _notesOrFailureToNotesList(
      Either<Failure, List<Note>> notesOrFailure) {
    return notesOrFailure.fold(
      (failure) => [],
      (notes) => notes,
    );
  }

  NoteState _unitOrFailureToNoteState(
      Either<Failure, Unit> unitOrFailure, Note note, List<Note> stateNotes) {
    return unitOrFailure.fold(
      (faliure) => const ErrorNotesState(
          message: "Something worng happend while loading the notes"),
      (unit) {
        return state;
      },
    );
  }
}
