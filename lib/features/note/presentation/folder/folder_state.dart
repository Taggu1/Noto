part of 'folder_cubit.dart';

class FolderState extends Equatable {
  List<Folder> folders;
  String currentName;
  FolderState({required this.folders, required this.currentName});

  @override
  List<Object> get props => [folders, currentName];
}
