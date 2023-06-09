import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/note/presentation/folder/folder_cubit.dart';

import '../note/note_bloc.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 10, left: 20, right: 20),
      child: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is LoadedNoteState || state is NoteWasNotFoundState) {
            return TextField(
              onChanged: (value) {
                final folderName =
                    BlocProvider.of<FolderCubit>(context).state.currentName;
                context.read<NoteBloc>().add(
                      SearchNoteEvent(
                        searchText: value,
                        currentFolderName: folderName,
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
