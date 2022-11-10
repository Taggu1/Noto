import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/core/constants/theme_constants.dart';
import 'package:note_app/core/utils/string.dart';
import 'package:note_app/core/widgets/loading_widget.dart';
import 'package:note_app/features/note/presentation/pages/edit_add_note_page.dart';

import '../../../../core/utils/rect.dart';
import '../../../../core/utils/widgets_extentions.dart';
import '../../../../core/widgets/buttons/app_back_button.dart';
import '../../../../core/widgets/custom_iconbutton_widget.dart';
import '../../domain/entities/note.dart';
import '../note/note_bloc.dart';

class NotePage extends StatefulWidget {
  final int index;
  static const routeName = '/note-page';
  const NotePage({Key? key, required this.index}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  bool deleted = false;

  @override
  Widget build(BuildContext context) {
    return !deleted
        ? BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state is LoadedNoteState) {
                final note = state.notes[widget.index];
                return Scaffold(
                  appBar: _buildAppBar(context, note, widget.index),
                  body: _buildBody(note),
                );
              } else {
                return const LoadingWidget();
              }
            },
          )
        : Container();
  }

  Padding _buildBody(Note note) {
    final bool withDrawing = note.drawing != null ? true : false;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              color: Colors.transparent,
              child: NoteTitleText(
                title: note.title!,
              ),
            ),
            addVerticalSpace(20),
            NoteDateText(
              time: note.time!,
            ),
            addVerticalSpace(20),
            if (withDrawing)
              NotePagePhotoWidget(
                drawing: note.drawing!,
              ),
            if (!withDrawing)
              NoteBodyText(
                body: note.body!,
              ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, Note note, int index) => AppBar(
        elevation: 0,
        leading: const AppBackButton(),
        actions: [
          CustomIconButton(
            icon: Icons.delete,
            buttonColor: Colors.red,
            onPressed: () {
              _removeWidget(index);
            },
          ),
          CustomIconButton(
            icon: Icons.edit,
            onPressed: () {
              Navigator.of(context).pushNamed(
                EditAddNotePage.routeName,
                arguments: [false, index],
              );
            },
          ),
        ],
      );

  _removeWidget(int index) {
    setState(() {
      deleted = true;
    });
    BlocProvider.of<NoteBloc>(context).add(RemoveNoteEvent(noteIndex: index));
    BlocProvider.of<NoteBloc>(context).add(FetchNotesEvent());
    Navigator.of(context).pop();
  }
}

class NoteBodyText extends StatelessWidget {
  final String body;
  const NoteBodyText({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      body,
      style: bodyTextStyle,
    );
  }
}

class NotePagePhotoWidget extends StatelessWidget {
  final Uint8List drawing;
  const NotePagePhotoWidget({
    Key? key,
    required this.drawing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Image.memory(drawing),
      ),
    );
  }
}

class NoteDateText extends StatelessWidget {
  final String time;
  const NoteDateText({Key? key, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      time.toFormatedDate(),
      style: dateTextStyle,
    );
  }
}

class NoteTitleText extends StatelessWidget {
  final String title;
  const NoteTitleText({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 30,
        height: 2,
      ),
    );
  }
}
