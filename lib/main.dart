import 'package:dynamic_color/dynamic_color.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/auth/presentation/pages/sync_page.dart';
import 'package:note_app/features/backup/presentation/bloc/backup_bloc_bloc.dart';
import 'package:note_app/features/backup/presentation/pages/backup_page.dart';
import 'package:note_app/features/habits/presentation/habit_bloc/habit_bloc.dart';
import 'package:note_app/features/note/presentation/folder/folder_cubit.dart';
import 'package:note_app/features/note/presentation/note/note_bloc.dart';
import 'package:note_app/features/note/presentation/pages/navigation_page.dart';
import 'package:note_app/features/theme/presentation/pages/settings_page.dart';
import 'package:note_app/features/todo/presentation/cubit/task_page_date_cubit.dart';
import 'package:note_app/features/todo/presentation/tasks/tasks_bloc.dart';

import 'dart:io' show Platform;

import 'features/auth/presentation/auth/auth_bloc.dart';
import 'features/theme/presentation/theme/theme_cubit.dart';
import 'injection_container.dart' as di;

const _brandBlue = Color.fromRGBO(148, 226, 213, 1);

CustomColors lightCustomColors = const CustomColors(danger: Color(0xFFE53935));
CustomColors darkCustomColors = const CustomColors(danger: Color(0xFFEF9A9A));

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
          create: (ctx) => di.sl<TaskPageDateCubit>(),
        ),
        BlocProvider(
          create: (ctx) => di.sl<ThemeCubit>()..fetchTheme(),
        ),
        BlocProvider(
          create: (ctx) => di.sl<FolderCubit>()..fetchFolders(),
        ),
        BlocProvider(
          create: (ctx) => di.sl<HabitBloc>()
            ..add(
              FetchHabitsEvent(),
            ),
        ),
        BlocProvider(
          create: (ctx) => di.sl<BackupBlocBloc>(),
        ),
        BlocProvider(
          create: (ctx) => di.sl<TasksBloc>()
            ..add(
              FetchTasksEvent(
                date: DateTime.now(),
              ),
            ),
        ),
        BlocProvider(
          create: (ctx) => di.sl<NoteBloc>()
            ..add(
              const FetchNotesEvent(),
            ),
        ),
        BlocProvider(create: (ctx) => di.sl<AuthBloc>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return DynamicColorBuilder(
              builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
            ColorScheme lightColorScheme;
            ColorScheme darkColorScheme;

            if (lightDynamic != null && darkDynamic != null) {
              lightColorScheme = lightDynamic.harmonized();

              darkColorScheme = darkDynamic.harmonized();
            } else {
              lightColorScheme = ColorScheme.fromSeed(
                seedColor: _brandBlue,
              );
              darkColorScheme = ColorScheme.fromSeed(
                seedColor: _brandBlue,
                brightness: Brightness.dark,
              );
            }

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Noto',
              theme: ThemeData(
                colorScheme: lightColorScheme,
                extensions: [lightCustomColors],
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                colorScheme: darkColorScheme,
                extensions: [darkCustomColors],
                useMaterial3: true,
              ),
              themeMode:
                  state.theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              routes: {
                '/': (ctx) => const NavigationPage(),
                BackupPage.routeName: (ctx) => const BackupPage(),
                SettingsPage.routeName: (ctx) => const SettingsPage(),
                SyncPage.routeName: (ctx) => const SyncPage(),
              },
            );
          });
        },
      ),
    );
  }
}

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.danger,
  });

  final Color? danger;

  @override
  CustomColors copyWith({Color? danger}) {
    return CustomColors(
      danger: danger ?? this.danger,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      danger: Color.lerp(danger, other.danger, t),
    );
  }

  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(danger: danger!.harmonizeWith(dynamic.primary));
  }
}
