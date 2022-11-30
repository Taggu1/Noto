part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NoteInitial extends NoteState {}

class LoadedNoteState extends NoteState {
  final List<Note> notes;

  const LoadedNoteState({required this.notes});

  @override
  List<Object> get props => [notes];
}

class LoadingNotesState extends NoteState {}

class ErrorNotesState extends NoteState {
  final String message;

  const ErrorNotesState({required this.message});

  @override
  List<Object> get props => [message];
}

class NoteWasNotFoundState extends NoteState {
  final String message;

  const NoteWasNotFoundState({required this.message});

  @override
  List<Object> get props => [message];
}
