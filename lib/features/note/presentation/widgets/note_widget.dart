import 'dart:io';

import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/core/constants/theme_constants.dart';
import 'package:note_app/features/note/presentation/folder/folder_cubit.dart';
import 'package:note_app/features/note/presentation/note/note_bloc.dart';
import 'package:note_app/features/note/presentation/pages/edit_add_note_page.dart';

import '../../domain/entities/note.dart';
import '../../../../core/utils/string.dart';

class NoteWidget extends StatelessWidget {
  final Note note;
  final int index;
  final bool toggledMode;
  final bool isToggled;
  final Function(String noteIndex) toggleHoldMode;
  const NoteWidget(
      {Key? key,
      required this.note,
      required this.index,
      required this.toggleHoldMode,
      required this.toggledMode,
      required this.isToggled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<Note>(
      onAccept: (details) {
        BlocProvider.of<NoteBloc>(context).add(
          ReOrderNotesEvent(
            draggedNote: details,
            targetNote: note,
          ),
        );
        Future.delayed(const Duration(milliseconds: 200), () {
          final foderName =
              BlocProvider.of<FolderCubit>(context).state.currentName;
          BlocProvider.of<NoteBloc>(context).add(
            FetchNotesEvent(
              folderName: foderName,
            ),
          );
        });
      },
      builder: (BuildContext context, List<Note?> candidateData,
          List<dynamic> rejectedData) {
        return Draggable<Note>(
          data: note,
          affinity: Axis.horizontal,
          childWhenDragging: Container(),
          feedback: _buildFeedbackWidget(context),
          child: Container(
            margin: const EdgeInsets.all(5),
            child: OpenContainer(
              openBuilder: (context, closedContainer) => EditAddNotePage(
                isAdd: false,
                noteIndex: index,
              ),
              closedBuilder: (context, openContainer) => InkWell(
                onTap: toggledMode
                    ? () {
                        toggleHoldMode(note.id);
                      }
                    : () => openContainer(),
                onLongPress: () {
                  toggleHoldMode(note.id);
                },
                child: _buildwidget(context),
              ),
              onClosed: (success) {},
              closedColor: note.color!.toMaterialColor(),
              closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: isToggled
                    ? BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.onBackground,
                      )
                    : BorderSide.none,
              ),
              openColor: Theme.of(context).colorScheme.background,
            ),
          ),
        );
      },
    );
  }

  Material _buildFeedbackWidget(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: note.color!.toMaterialColor(),
          borderRadius: BorderRadius.circular(12),
        ),
        child: _buildwidget(context),
      ),
    );
  }

  Widget _buildwidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (note.externalImagePath != null)
            Image.file(
              File(
                note.externalImagePath!,
              ),
              fit: BoxFit.fitWidth,
              errorBuilder: (context, error, stackTrace) => Container(),
            ),
          if (note.externalImagePath == null && note.drawing != null)
            Image.memory(
              note.drawing!,
              fit: BoxFit.fitWidth,
              errorBuilder: (context, error, stackTrace) => Container(),
            ),
          Container(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (note.title != null && note.title!.isNotEmpty) ...[
                    AutoSizeText(
                      note.title!,
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 20,
                        color: kBlackColor,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 5,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                  AutoSizeText(
                    note.time!.toFormatedDate(),
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 17,
                      color: kBlackColor.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
