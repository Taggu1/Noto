import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/note/presentation/folder/folder_cubit.dart';
import 'package:note_app/features/note/presentation/widgets/add_folder_dialog.dart';

import '../../domain/entities/folder.dart';
import 'folder_widget.dart';

class SelectFolderWidget extends StatelessWidget {
  const SelectFolderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FolderCubit, FolderState>(
      builder: (context, state) {
        final folders = state.folders;
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onInverseSurface,
              borderRadius: BorderRadius.circular(16),
            ),
            height: 70,
            child: _buildRow(context, folders, state.currentName),
          ),
        );
      },
    );
  }

  SingleChildScrollView _buildRow(
      BuildContext context, List<Folder> folders, String currentFolderName) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...folders
              .map(
                (folder) => FolderWidget(
                  folder: folder,
                  selected: currentFolderName == folder.folderName,
                ),
              )
              .toList(),
          IconButton(
            onPressed: () => _addFolder(context),
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
    );
  }

  void _addFolder(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddFolderDialog(),
    );
  }
}
