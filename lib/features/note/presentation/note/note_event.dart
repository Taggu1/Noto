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
  final FunType addOrEdit;
  final int? index;

  const EditOrAddNoteEvent(
      {required this.note, required this.addOrEdit, this.index});

  @override
  // TODO: implement props
  List<Object> get props => [note, addOrEdit];
}

class RemoveNoteEvent extends NoteEvent {
  final String noteId;

  const RemoveNoteEvent({required this.noteId});

  @override
  // TODO: implement props
  List<Object> get props => [noteId];
}
