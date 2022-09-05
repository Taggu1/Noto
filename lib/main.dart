import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:note_app/core/models/hive_offset.dart';
import 'package:note_app/features/backup/presentation/bloc/backup_bloc_bloc.dart';
import 'package:note_app/features/backup/presentation/pages/backup_page.dart';
import 'package:note_app/features/note/domain/entities/note.dart';
import 'package:note_app/features/note/presentation/note/note_bloc.dart';
import 'package:note_app/features/note/presentation/pages/notes_page.dart';
import 'package:note_app/features/note/presentation/pages/edit_add_note_page.dart';
import 'package:path_provider/path_provider.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DesktopWindow.setMinWindowSize(const Size(300, 600));
  final dir = await getApplicationDocumentsDirectory();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => di.sl<NoteBloc>()
            ..add(
              FetchNotesEvent(),
            ),
        ),
        BlocProvider(
          create: (ctx) => di.sl<BackupBlocBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Noto',
        theme: ThemeData.dark(),
        routes: {
          '/': (ctx) => const NotesPage(),
          EditAddNotePage.routeName: (ctx) => const EditAddNotePage(),
          BackupPage.routeName: (ctx) => const BackupPage(),
        },
      ),
    );
  }
}
