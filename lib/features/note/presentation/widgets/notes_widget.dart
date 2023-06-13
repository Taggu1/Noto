import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:note_app/features/auth/presentation/auth/auth_bloc.dart';
import 'package:note_app/features/note/presentation/folder/folder_cubit.dart';
import 'package:note_app/features/note/presentation/note/note_bloc.dart';

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

    final authState = BlocProvider.of<AuthBloc>(context).state;

    if (authState is AuthenticatedAuthState) {
      userId = authState.user.id;
      folderName = BlocProvider.of<FolderCubit>(context).state.currentName;
      _watchNoteChanges(folderName);
    }
  }

  void _watchNoteChanges(String folderName) {
    FirebaseFirestore.instance
        .collection("notes")
        .where(
          "userId",
          isEqualTo: userId,
        )
        .orderBy("index", descending: true)
        .snapshots()
        .listen((event) {
      if (mounted && event.docChanges.isNotEmpty) {
        final change = event.docChanges.last;

        final noteDoc = change.doc;

        final note = Note.fromFirebase(
          noteDoc.data()!,
          change.doc.id,
        );

        switch (change.type) {
          case DocumentChangeType.added || DocumentChangeType.modified:
            if (!widget.notes.contains(note)) {
              BlocProvider.of<NoteBloc>(context).add(
                EditOrAddNoteEvent(note: note),
              );

              BlocProvider.of<NoteBloc>(context).add(
                FetchNotesEvent(folderName: folderName),
              );
            }

          case DocumentChangeType.removed:
            if (widget.notes.contains(note)) {
              BlocProvider.of<NoteBloc>(context).add(
                RemoveNoteEvent(noteId: noteDoc.id),
              );

              BlocProvider.of<NoteBloc>(context).add(
                FetchNotesEvent(folderName: folderName),
              );
            }
        }
      }
    });
  }

  void _fetchNotes() {}

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
