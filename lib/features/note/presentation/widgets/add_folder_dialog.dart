import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:note_app/features/note/domain/entities/folder.dart';
import 'package:note_app/features/note/presentation/folder/folder_cubit.dart';
import 'package:note_app/features/note/presentation/note/note_bloc.dart';
import 'package:note_app/features/note/presentation/widgets/toggle_mode_actions.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/widgets/custom_iconbutton_widget.dart';
import '../../../todo/presentation/widgets/sheet_title_row.dart';
import '../../../todo/presentation/widgets/sheet_text_field.dart';

class AddFolderDialog extends StatefulWidget {
  final Folder? folder;
  const AddFolderDialog({super.key, this.folder});

  @override
  State<AddFolderDialog> createState() => _AddFolderDialogState();
}

class _AddFolderDialogState extends State<AddFolderDialog> {
  late TextEditingController _controller;
  String? _id;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    if (widget.folder != null) {
      _controller.text = widget.folder!.folderName;
      _id = widget.folder!.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 210,
          child: Column(
            children: [
              SheetTitleRow(
                text: "Add Folder",
                add: _add,
              ),
              const SizedBox(
                height: 15,
              ),
              SheetTextField(
                hintText: "Folder Name",
                controller: _controller,
                maxLength: 40,
                maxLines: 1,
              ),
              if (widget.folder != null)
                CustomIconButton(
                  onPressed: () => _deleteFolder(context),
                  icon: Entypo.trash,
                ),
            ],
          ),
        ),
      ),
    );
  }

  _add(BuildContext context, bool pop) {
    if (_controller.text.isNotEmpty) {
      BlocProvider.of<FolderCubit>(context).addFolder(
        folder: Folder(
          folderName: _controller.text,
          id: _id ?? const Uuid().v4(),
        ),
      );

      if (widget.folder != null) {
        BlocProvider.of<NoteBloc>(context).add(
          RemoveOrRenameFolderNotes(
            oldFolderName: widget.folder!.folderName,
            isRemove: false,
            newFolderName: _controller.text,
          ),
        );
      }
    }

    Navigator.of(context).pop();
  }

  void _deleteFolder(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => CustomAlertDialog(
        onDelete: () {
          BlocProvider.of<FolderCubit>(context)
              .removeFolder(folder: widget.folder!);
          BlocProvider.of<NoteBloc>(context).add(
            RemoveOrRenameFolderNotes(
              oldFolderName: widget.folder!.folderName,
              isRemove: true,
              newFolderName: _controller.text,
            ),
          );
          BlocProvider.of<NoteBloc>(context).add(
            const FetchNotesEvent(
              folderName: "All",
            ),
          );
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        text: 'Are you sure that you want to delete this folder?',
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
