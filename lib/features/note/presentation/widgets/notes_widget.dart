import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/features/note/presentation/folder/folder_cubit.dart';

import '../../domain/entities/note.dart';
import 'note_widget.dart';

class NotesWidget extends StatefulWidget {
  final List<Note> notes;
  final void Function(String noteIndex) toggleHoldMode;
  final bool toggledMode;
  final List<String> toggledNotesIndexes;

  const NotesWidget({
    Key? key,
    required this.notes,
    required this.toggleHoldMode,
    required this.toggledMode,
    required this.toggledNotesIndexes,
  }) : super(key: key);

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  String? userId;
  String folderName = "All";

  @override
  void initState() {
    super.initState();

    folderName = BlocProvider.of<FolderCubit>(context).state.currentName;
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.extent(
      maxCrossAxisExtent: 90,
      mainAxisSpacing: 3.0,
      crossAxisSpacing: 4.0, // I only need two card horizontally

      //Here is the place that we are getting flexible/ dynamic card for various images
      children: widget.notes.reversed.map<StaggeredGridTile>(
        (note) {
          final index = widget.notes.indexOf(note);
          return StaggeredGridTile.fit(
              crossAxisCellCount: 2,
              child: NoteWidget(
                note: note,
                index: index,
                key: ValueKey(note.id),
                toggleHoldMode: widget.toggleHoldMode,
                toggledMode: widget.toggledMode,
                isToggled: widget.toggledNotesIndexes.contains(note.id),
              ));
        },
      ).toList(), // add some space
    );

    /* return ReorderableGridView.builder(
      onReorder: _onReorder,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
      ),
      itemBuilder: (BuildContext context, int index) {
        return NoteWidget(
          note: widget.notes[index],
          index: index,
          key: ValueKey(widget.notes[index].id),
        );
      },
      itemCount: widget.notes.length,
    );*/
  }
}
