import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:note_app/core/constants/theme_constants.dart';
import 'package:note_app/core/widgets/custom_iconbutton_widget.dart';
import 'package:note_app/core/widgets/loading_widget.dart';
import 'package:note_app/features/backup/presentation/pages/backup_page.dart';
import 'package:note_app/features/note/data/repositories/note_repository_impl.dart';
import 'package:note_app/features/note/domain/entities/note.dart';
import 'package:note_app/features/note/presentation/note/note_bloc.dart';
import 'package:note_app/features/note/presentation/pages/edit_add_note_page.dart';
import 'package:xen_popup_card/xen_card.dart';

import '../widgets/notes_widget.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: _buildBody(context),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: _buildExpandableFap(context),
    );
  }

  SafeArea _buildBody(BuildContext ctx) => SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<NoteBloc, NoteState>(
                builder: (context, state) {
                  if (state is LoadedNoteState) {
                    if (state.notes.isEmpty) {
                      return Center(
                        child: Text(
                          "Add some notes",
                          style: titleTextStyle,
                        ),
                      );
                    }
                    return NotesWidget(
                      notes: state.notes,
                    );
                  } else if (state is ErrorNotesState) {
                    return Center(
                      child: Text(
                        "Something went wrong",
                        style: titleTextStyle,
                      ),
                    );
                  } else {
                    return const LoadingWidget();
                  }
                },
              ),
            ),
          ],
        ),
      );

  ExpandableFab _buildExpandableFap(BuildContext context) {
    return ExpandableFab(
      backgroundColor: kGreyColor,
      foregroundColor: kWhiteColor,
      closeButtonStyle: const ExpandableFabCloseButtonStyle(
        backgroundColor: kGreyColor,
        foregroundColor: kWhiteColor,
      ),
      children: [
        CustomIconButton(
            onPressed: () => _backupButtonOnPressedFunc(context),
            icon: Icons.backup),
        CustomIconButton(
          onPressed: () => _addButtonOnPressedFunc(context),
          icon: Icons.add,
        ),
      ],
    );
  }

  _addButtonOnPressedFunc(BuildContext context) {
    Navigator.of(context)
        .pushNamed(EditAddNotePage.routeName, arguments: [true]);
  }

  _backupButtonOnPressedFunc(BuildContext context) {
    Navigator.of(context).pushNamed(BackupPage.routeName);
  }
}
