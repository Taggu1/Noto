part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class FetchNotesEvent extends NoteEvent {}

class ReOrderNotesEvent extends NoteEvent {
  final List<Note> notes;

  const ReOrderNotesEvent({required this.notes});

  @override
  List<Object> get props => [notes];
}

class EditOrAddNoteEvent extends NoteEvent {
  final Note note;
  final NoteFunctionType addOrEdit;
  final int? index;

  const EditOrAddNoteEvent(
      {required this.note, required this.addOrEdit, this.index});

  @override
  List<Object> get props => [note, addOrEdit];
}

class RemoveNoteEvent extends NoteEvent {
  final int noteIndex;

  const RemoveNoteEvent({required this.noteIndex});

  @override
  List<Object> get props => [noteIndex];
}
