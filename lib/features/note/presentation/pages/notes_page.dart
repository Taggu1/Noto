import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/constants/theme_constants.dart';
import 'package:note_app/features/note/presentation/note/note_bloc.dart';
import 'package:note_app/features/note/presentation/pages/edit_add_note_page.dart';
import 'package:note_app/features/note/presentation/widgets/app_drawer.dart';
import 'package:note_app/features/note/presentation/widgets/custom_text_field.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../widgets/notes_page_appbar.dart';
import '../widgets/notes_widget.dart';

class NotesPage extends StatelessWidget {
  static const routeName = "/";
  const NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addButtonOnPressedFunc(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildBody(BuildContext ctx) => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 110),
            child: Builder(
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: BlocBuilder<NoteBloc, NoteState>(
                          builder: (context, state) {
                            if (state is LoadedNoteState) {
                              if (state.notes.isEmpty) {
                                return const Center(
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
                              return const Center(
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
              },
            ),
          ),
          SearchBar(),
        ],
      );

  _addButtonOnPressedFunc(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => const EditAddNotePage(
                isAdd: true,
                noteIndex: 0,
              )),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 10,
      right: 10,
      child: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is LoadedNoteState) {
            return TextField(
              onChanged: (value) {
                context.read<NoteBloc>().add(
                      SearchNoteEvent(
                        searchText: value,
                        notes: state.notes,
                      ),
                    );
              },
              autofocus: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                contentPadding: EdgeInsets.all(16),
                prefixIcon: IconButton(
                  icon: const Icon(
                    Icons.menu,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
