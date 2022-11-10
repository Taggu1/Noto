import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/core/constants/theme_constants.dart';
import 'package:note_app/core/utils/scheme_utils.dart';
import 'package:note_app/features/backup/presentation/bloc/backup_bloc_bloc.dart';
import 'package:note_app/features/backup/presentation/pages/backup_page.dart';
import 'package:note_app/features/note/presentation/note/note_bloc.dart';
import 'package:note_app/features/note/presentation/pages/notes_page.dart';
import 'package:note_app/features/note/presentation/pages/edit_add_note_page.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:note_app/features/theme/presentation/pages/scheme_page.dart';
import 'package:note_app/features/theme/presentation/pages/settings_page.dart';

import 'dart:io' show Platform;

import 'features/theme/presentation/theme/theme_cubit.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!Platform.isAndroid || !Platform.isIOS) {}
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
          create: (ctx) => di.sl<ThemeCubit>()..fetchTheme(),
        ),
        BlocProvider(
          create: (ctx) => di.sl<BackupBlocBloc>(),
        ),
        BlocProvider(
          create: (ctx) => di.sl<NoteBloc>()
            ..add(
              FetchNotesEvent(),
            ),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Noto',
            theme: FlexThemeData.light(
              scheme: mapIndexToScheme(state.theme.flexThemeIndex),
              useMaterial3: true,
              surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
              visualDensity: FlexColorScheme.comfortablePlatformDensity,
              blendLevel: 20,
              useMaterial3ErrorColors: true,
            ),
            darkTheme: FlexThemeData.dark(
              scheme: mapIndexToScheme(state.theme.flexThemeIndex),
              useMaterial3: true,
              surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
              visualDensity: FlexColorScheme.comfortablePlatformDensity,
              blendLevel: 20,
              useMaterial3ErrorColors: true,
            ),
            themeMode:
                state.theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            routes: {
              '/': (ctx) => const NotesPage(),
              BackupPage.routeName: (ctx) => const BackupPage(),
              SettingsPage.routeName: (ctx) => const SettingsPage(),
              SchemePage.routeName: (ctx) => const SchemePage(),
            },
          );
        },
      ),
    );
  }
}
