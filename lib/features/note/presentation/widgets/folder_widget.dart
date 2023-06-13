import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/note/domain/entities/folder.dart';
import 'package:note_app/features/note/presentation/folder/folder_cubit.dart';
import 'package:note_app/features/note/presentation/widgets/add_folder_dialog.dart';

import '../../domain/entities/note.dart';
import '../note/note_bloc.dart';

class FolderWidget extends StatelessWidget {
  final Folder folder;
  final bool selected;
  const FolderWidget({super.key, required this.folder, required this.selected});

  @override
  Widget build(BuildContext context) {
    return DragTarget<Note>(
      onAccept: (details) => _onAccept(details, context),
      builder: (BuildContext context, List<Note?> candidateData,
          List<dynamic> rejectedData) {
        return Padding(
          padding: const EdgeInsets.all(13),
          child: InkWell(
            onTap: () => _onTap(context),
            onLongPress: () =>
                folder.folderName != "All" ? _editFolder(context) : null,
            child: Column(
              children: [
                Icon(
                  Icons.folder,
                  color: selected
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).colorScheme.onBackground,
                ),
                Text(
                  folder.folderName,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onAccept(Note details, BuildContext context) {
    BlocProvider.of<NoteBloc>(context).add(
      EditOrAddNoteEvent(
        note: details.copyWith(
          folderName: folder.folderName,
        ),
      ),
    );
    final currentFolder =
        BlocProvider.of<FolderCubit>(context).state.currentName;

    BlocProvider.of<NoteBloc>(context).add(
      FetchNotesEvent(
        folderName: currentFolder,
      ),
    );
  }

  void _editFolder(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddFolderDialog(
        folder: folder,
      ),
    );
  }

  void _onTap(BuildContext context) {
    BlocProvider.of<NoteBloc>(context).add(
      FetchNotesEvent(
        folderName: folder.folderName,
      ),
    );
    BlocProvider.of<FolderCubit>(context).changeCurrentFolder(
      folderName: folder.folderName,
    );
  }
}
