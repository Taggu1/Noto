part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class FetchNotesEvent extends NoteEvent {
  final String? folderName;

  const FetchNotesEvent({this.folderName});
}

class EditOrAddNoteEvent extends NoteEvent {
  final Note note;
  final bool onlineAdd;

  const EditOrAddNoteEvent({
    required this.note,
    this.onlineAdd = true,
  });

  @override
  List<Object> get props => [note];
}

class ReOrderNotesEvent extends NoteEvent {
  final Note draggedNote;
  final Note targetNote;

  const ReOrderNotesEvent({
    required this.draggedNote,
    required this.targetNote,
  });

  @override
  List<Object> get props => [draggedNote, targetNote];
}

class RemoveNoteEvent extends NoteEvent {
  final String noteId;

  const RemoveNoteEvent({required this.noteId});

  @override
  List<Object> get props => [noteId];
}

class RemoveNotesEvent extends NoteEvent {
  final List<String> idsList;

  const RemoveNotesEvent({required this.idsList});

  @override
  List<Object> get props => [idsList];
}

class SearchNoteEvent extends NoteEvent {
  final String searchText;
  final String? currentFolderName;

  const SearchNoteEvent({
    required this.searchText,
    this.currentFolderName,
  });

  @override
  List<Object> get props => [searchText];
}

class RemoveOrRenameFolderNotes extends NoteEvent {
  final String oldFolderName;
  final String newFolderName;
  final bool isRemove;

  const RemoveOrRenameFolderNotes({
    required this.oldFolderName,
    required this.isRemove,
    required this.newFolderName,
  });

  @override
  List<Object> get props => [oldFolderName, isRemove];
}
