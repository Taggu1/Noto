import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app/features/note/presentation/note/note_bloc.dart';

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
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: StaggeredGrid.extent(
        maxCrossAxisExtent: 90,
        mainAxisSpacing: 3.0,
        crossAxisSpacing: 4.0, // I only need two card horizontally

        //Here is the place that we are getting flexible/ dynamic card for various images
        children: widget.notes.reversed
            .map<StaggeredGridTile>(
              (note) => StaggeredGridTile.fit(
                  crossAxisCellCount: 2,
                  child: NoteWidget(
                    note: note,
                    index: widget.notes.indexOf(note),
                    key: ValueKey(note.id),
                  )),
            )
            .toList(), // add some space
      ),
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
