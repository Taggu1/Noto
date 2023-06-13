import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/core/constants/theme_constants.dart';
import 'package:note_app/features/note/presentation/note/note_bloc.dart';
import 'package:note_app/features/note/presentation/widgets/select_folder_widget.dart';

import 'package:note_app/features/note/presentation/widgets/toggle_mode_actions.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/no_data_widget.dart';
import '../widgets/notes_widget.dart';
import '../widgets/search_bar.dart';

class NotesPage extends StatefulWidget {
  static const routeName = "/";
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  bool _toggleMode = false;

  final List<String> _toggledNotesIndexes = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext ctx) => Expanded(
        child: ListView(
          children: [
            _toggleMode
                ? ToggleModeActions(
                    notesIds: _toggledNotesIndexes,
                    offToggleMode: _offToggleMode,
                    onDelete: _onDelete,
                  )
                : const AppSearchBar(),
            const SelectFolderWidget(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                child: BlocBuilder<NoteBloc, NoteState>(
                  builder: (context, state) {
                    if (state is LoadedNoteState) {
                      if (state.notes.isEmpty) {
                        return const NoDataWidget(
                          animationUrl: "assets/lottie/nothing.json",
                          text: 'Add some notes',
                        );
                      }
                      return NotesWidget(
                        notes: state.notes,
                        toggleHoldMode: _toggleHoldMode,
                        toggledMode: _toggleMode,
                        toggledNotesIndexes: _toggledNotesIndexes,
                      );
                    } else if (state is ErrorNotesState) {
                      return const Center(
                        child: Text(
                          "Something went wrong",
                          style: titleTextStyle,
                        ),
                      );
                    } else if (state is NoteWasNotFoundState) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Note was not found",
                            style: titleTextStyle.copyWith(fontSize: 25),
                          ),
                          Lottie.asset(
                            "assets/lottie/space-in-purple.json",
                            fit: BoxFit.contain,
                            height: 300,
                          ),
                        ],
                      );
                    } else {
                      return const LoadingWidget();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      );

  void _toggleHoldMode(String noteId) {
    if (_toggledNotesIndexes.contains(noteId)) {
      _toggledNotesIndexes.remove(noteId);
    } else {
      _toggledNotesIndexes.add(noteId);
    }

    if (_toggleMode == false) {
      _toggleMode = true;
    } else if (_toggledNotesIndexes.isEmpty) {
      _toggleMode = false;
    }
    setState(() {});
  }

  void _offToggleMode() {
    if (_toggledNotesIndexes.isNotEmpty) {
      _toggledNotesIndexes.clear();
    }
    setState(() {
      _toggleMode = false;
    });
  }

  void _onDelete() {
    Navigator.of(context).pop();
    BlocProvider.of<NoteBloc>(context).add(
      RemoveNotesEvent(idsList: _toggledNotesIndexes),
    );

    Future.delayed(
      const Duration(
        seconds: 1,
      ),
      () {
        _offToggleMode();

        BlocProvider.of<NoteBloc>(context).add(const FetchNotesEvent());
      },
    );
  }
}
