import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:note_app/features/note/domain/entities/note.dart';
import 'package:note_app/features/note/presentation/note/note_bloc.dart';
import 'package:note_app/features/note/presentation/pages/note_page.dart';
import 'package:note_app/features/note/presentation/pages/notes_page.dart';
import 'package:note_app/features/note/presentation/widgets/add_note_popup_card.dart';
import 'package:path_provider/path_provider.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();

  Hive.init(dir.path + "/notes/");

  Hive.registerAdapter(NoteAdapter());

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Note app',
        theme: ThemeData.dark(),
        routes: {
          '/': (ctx) => const NotesPage(),
          EditAddNotePage.routeName: (ctx) => EditAddNotePage()
        },
      ),
    );
  }
}
