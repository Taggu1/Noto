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

import '../../domain/entities/note.dart';
import '../../../../core/utils/string.dart';

class NoteWidget extends StatelessWidget {
  final Note note;
  final int index;
  const NoteWidget({Key? key, required this.note, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _ontap(context),
      child: Container(
        decoration: BoxDecoration(
          color: note.color!.toMaterialColor(),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AutoSizeText(
                note.title!,
                style: GoogleFonts.robotoCondensed(
                  fontSize: 22,
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
    );
  }

  _ontap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => NotePage(index: index),
      ),
    );
  }
}
