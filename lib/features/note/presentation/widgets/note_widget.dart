import 'dart:ui';
import 'dart:io';

import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:note_app/core/constants/theme_constants.dart';
import 'package:note_app/features/note/presentation/pages/note_page.dart';
import 'package:note_app/features/note/presentation/pages/edit_add_note_page.dart';

import '../../../../core/utils/rect.dart';
import '../../domain/entities/note.dart';
import '../../../../core/utils/string.dart';

class NoteWidget extends StatelessWidget {
  final Note note;
  final int index;
  const NoteWidget({Key? key, required this.note, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: OpenContainer(
        openBuilder: (context, closedContainer) => EditAddNotePage(
          isAdd: false,
          noteIndex: index,
        ),
        closedBuilder: (context, openContainer) => InkWell(
          onTap: () => openContainer(),
          child: _buildwidget(context),
        ),
        onClosed: (success) {},
        closedColor: note.color!.toMaterialColor(),
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        openColor: Theme.of(context).backgroundColor,
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

  _ontap(BuildContext context) {
    ;
  }
}
