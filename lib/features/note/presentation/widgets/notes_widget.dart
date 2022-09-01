import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/note/presentation/note/note_bloc.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

import '../../domain/entities/note.dart';
import 'note_widget.dart';

class NotesWidget extends StatefulWidget {
  final List<Note> notes;
  const NotesWidget({
    Key? key,
    required this.notes,
  }) : super(key: key);

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      final item = widget.notes.removeAt(oldIndex);
      widget.notes.insert(newIndex, item);
    });
    BlocProvider.of<NoteBloc>(context)
        .add(ReOrderNotesEvent(notes: widget.notes));
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableGridView.builder(
      onReorder: _onReorder,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
      ),
      itemBuilder: (BuildContext context, int index) {
        return NoteWidget(
          note: widget.notes[index],
          index: index,
          key: ValueKey(widget.notes[index].id),
        );
      },
      itemCount: widget.notes.length,
    );
  }
}
