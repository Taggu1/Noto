import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/constants/theme_constants.dart';
import 'package:note_app/core/widgets/loading_widget.dart';
import 'package:note_app/features/note/data/repositories/note_repository_impl.dart';
import 'package:note_app/features/note/domain/entities/note.dart';
import 'package:note_app/features/note/presentation/note/note_bloc.dart';
import 'package:note_app/features/note/presentation/widgets/add_note_popup_card.dart';
import 'package:xen_popup_card/xen_card.dart';

import '../widgets/notes_widget.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: _buildBody(context),
    );
  }

  SafeArea _buildBody(BuildContext ctx) => SafeArea(
    child: Column(
          children: [
            Expanded(
              child: BlocBuilder<NoteBloc, NoteState>(
                builder: (context, state) {
                  if (state is LoadedNoteState) {
                    return NotesWidget(
                      notes: state.notes,
                    );
                  } else {
                    return const LoadingWidget();
                  }
                },
              ),
            ),
            _buildIconButton(ctx),
          ],
        ),
  );

  IconButton _buildIconButton(BuildContext context) {
    return IconButton(
      onPressed: () => _buttonOnPressedFunc(context),
      icon: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  _buttonOnPressedFunc(BuildContext context) {
    Navigator.of(context)
        .pushNamed(EditAddNotePage.routeName, arguments: [true]);
  }
}
