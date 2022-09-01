import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/core/constants/theme_constants.dart';
import 'package:note_app/core/utils/string.dart';
import 'package:note_app/core/widgets/loading_widget.dart';
import 'package:note_app/features/note/data/repositories/note_repository_impl.dart';
import 'package:note_app/features/note/presentation/widgets/add_note_popup_card.dart';

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
                return Scaffold(
                  backgroundColor: kBlackColor,
                  appBar: _buildAppBar(
                      context, state.notes[widget.index], widget.index),
                  body: _buildBody(state.notes[widget.index]),
                );
              } else {
                return LoadingWidget();
              }
            },
          )
        : Container();
  }

  Padding _buildBody(Note note) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (note.drawing != null)
              Container(
                color: Colors.white,
                child: Image.memory(note.drawing!),
              ),
            Text(
              note.title!,
              style: GoogleFonts.roboto(
                color: kWhiteColor,
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              note.time!.toFormatedDate(),
              style: GoogleFonts.roboto(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              note.body!,
              style: GoogleFonts.roboto(
                color: kWhiteColor,
                fontWeight: FontWeight.w300,
                fontSize: 17,
                height: 1.8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, Note note, int index) => AppBar(
        backgroundColor: kBlackColor,
        elevation: 0,
        leading: CustomIconButton(
          icon: Icons.arrow_back,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          CustomIconButton(
            icon: Icons.delete,
            buttonColor: Colors.red,
            onPressed: () {
              setState(() {
                deleted = true;
              });
              BlocProvider.of<NoteBloc>(context)
                  .add(RemoveNoteEvent(noteIndex: index));
              BlocProvider.of<NoteBloc>(context).add(FetchNotesEvent());
              Navigator.of(context).pop();
            },
          ),
          CustomIconButton(
            icon: Icons.edit,
            onPressed: () {
              Navigator.of(context).pushNamed(EditAddNotePage.routeName,
                  arguments: [false, index]);
            },
          ),
        ],
      );
}
