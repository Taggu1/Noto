import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'package:note_app/core/constants/strings.dart';
import 'package:note_app/core/data_sources/local_data_source.dart';

import 'package:note_app/features/backup/data/data_sources/backup_local_data_source.dart';
import 'package:note_app/features/backup/data/repository/backup_repository_impl.dart';
import 'package:note_app/features/backup/domain/repository/backup_repository.dart';
import 'package:note_app/features/backup/domain/use_cases/backup_use_case.dart';
import 'package:note_app/features/backup/domain/use_cases/restore_use_case.dart';
import 'package:note_app/features/backup/presentation/bloc/backup_bloc_bloc.dart';
import 'package:note_app/features/habits/data/repository/habit_repository_impl.dart';
import 'package:note_app/features/habits/domain/models/habit.dart';
import 'package:note_app/features/habits/domain/repository/habit_repository.dart';
import 'package:note_app/features/habits/presentation/habit_bloc/habit_bloc.dart';
import 'package:note_app/features/note/data/data_sources/note_local_data_source.dart';
import 'package:note_app/features/note/data/data_sources/note_remote_data_source.dart';
import 'package:note_app/features/note/data/repositories/note_repository_impl.dart';
import 'package:note_app/features/note/domain/entities/folder.dart';
import 'package:note_app/features/note/domain/entities/note.dart';
import 'package:note_app/features/note/domain/repositories/note_repository.dart';
import 'package:note_app/features/note/domain/use_cases/add_note_use_case.dart';
import 'package:note_app/features/note/domain/use_cases/fetch_notes_use_case.dart';
import 'package:note_app/features/note/domain/use_cases/re_order_notes_use_case.dart';
import 'package:note_app/features/note/domain/use_cases/remove_note_use_case.dart';
import 'package:note_app/features/note/presentation/folder/folder_cubit.dart';
import 'package:note_app/features/note/presentation/note/note_bloc.dart';
import 'package:note_app/features/theme/data/data_sources/theme_local_db.dart';
import 'package:note_app/features/theme/data/repositories/theme_repo_impl.dart';
import 'package:note_app/features/theme/domain/entities/theme.dart';
import 'package:note_app/features/theme/domain/repository/theme_repo.dart';
import 'package:note_app/features/theme/domain/use_cases/fetch_theme_use_case.dart';
import 'package:note_app/features/theme/domain/use_cases/save_theme_use_case.dart';
import 'package:note_app/features/todo/data/repositories/task_repo.dart';
import 'package:note_app/features/todo/domain/entities/task.dart';
import 'package:note_app/features/todo/domain/repository/tasks_repo.dart';
import 'package:note_app/features/todo/presentation/cubit/task_page_date_cubit.dart';
import 'package:note_app/features/todo/presentation/tasks/tasks_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/models/hive_offset.dart';
import 'features/auth/data/data_sources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentation/auth/auth_bloc.dart';
import 'features/theme/presentation/theme/theme_cubit.dart';
import 'firebase_options.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features

  // Bloc

  sl.registerFactory(
    () => TasksBloc(
      tasksRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => HabitBloc(
      sl(),
    ),
  );

  sl.registerFactory(
    () => NoteBloc(
      fetchNotesUseCase: sl(),
      removeNoteUseCase: sl(),
      addOrEditNoteUseCase: sl(),
      reOrderNotesUseCase: sl(),
    ),
  );

  sl.registerFactory(() => TaskPageDateCubit());

  sl.registerFactory(() => BackupBlocBloc(
        backupUseCase: sl(),
        restoreUseCase: sl(),
      ));

  sl.registerFactory(
    () => ThemeCubit(
      sl(),
      sl(),
    ),
  );

  sl.registerFactory(
    () => FolderCubit(
      localDataSource: sl(),
    ),
  );

  sl.registerFactory(
    () => AuthBloc(
      repository: sl(),
    ),
  );

  // UseCase

  sl.registerLazySingleton<HabitRepository>(
    () => HabitRepositoryImpl(
      localDataSourceImpl: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => FetchThemeUseCase(
      sl(),
    ),
  );

  sl.registerLazySingleton(
    () => SaveThemeUseCase(
      sl(),
    ),
  );

  sl.registerLazySingleton(
    () => BackupUseCase(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => RestoreUseCase(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => ReOrderNotesUseCase(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => FetchNotesUseCase(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => RemoveNoteUseCase(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => AddOrEditNoteUseCase(
      repository: sl(),
    ),
  );

  // Repositories

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: sl(),
      notesRepository: sl(),
    ),
  );

  sl.registerLazySingleton<TasksRepository>(
    () => TasksRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(
      themeLocalDatabase: sl(),
    ),
  );

  sl.registerLazySingleton<BackupRepository>(
    () => BackUpRepositoyImpl(
      backupLocalDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<NotesRepository>(
    () => NoteRepositoryImpl(
      noteLocalDataSource: sl(),
      localDataSourceImpl: sl(),
      noteRemoteDataSource: sl(),
    ),
  );

  // DataSources

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      auth: sl(),
      database: sl(),
    ),
  );

  sl.registerLazySingleton<ThemeLocalSource>(
    () => ThemeLocalSourceImpl(
      hiveBox: sl(),
    ),
  );

  sl.registerLazySingleton<BackupLocalDataSource>(
    () => BackupLocalDataSourceImpl(
      hiveBox: sl(),
    ),
  );

  sl.registerLazySingleton<NoteLocalDataSource>(
    () => NoteLocalDataSourceImpl(
      hiveBox: sl(),
    ),
  );

  sl.registerLazySingleton<LocalDataSource<Note>>(
    () => LocalDataSourceImpl<Note>(
      sl(),
    ),
  );

  sl.registerLazySingleton<LocalDataSource<Folder>>(
    () => LocalDataSourceImpl<Folder>(
      sl(),
    ),
  );

  sl.registerLazySingleton<LocalDataSource<AppTask>>(
    () => LocalDataSourceImpl<AppTask>(
      sl(),
    ),
  );

  sl.registerLazySingleton<LocalDataSource<Habit>>(
    () => LocalDataSourceImpl<Habit>(
      sl(),
    ),
  );

  sl.registerLazySingleton<NoteRemoteDataSource>(
    () => NoteRemoteDataSourceImpl(
      db: sl(),
      auth: sl(),
    ),
  );

  // External
  final dir = await getApplicationDocumentsDirectory();

  Hive.init("${dir.path}/Notes/s/");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Hive.registerAdapter(HiveOffsetAdapter());
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(ThemeAdapter());
  Hive.registerAdapter(AppTaskAdapter());
  Hive.registerAdapter(HabitAdapter());
  Hive.registerAdapter(FolderAdapter());
  final notesBox = await Hive.openBox<Note>(kNotesBoxName);
  final themeBox = await Hive.openBox<Theme>(kThemeBoxName);
  final tasksBox = await Hive.openBox<AppTask>(kTasksBoxName);
  final habitsBox = await Hive.openBox<Habit>(kHabitBoxName);
  final foldersBox = await Hive.openBox<Folder>(kFolderBoxName);
  sl.registerLazySingleton(() => notesBox);

  sl.registerLazySingleton(() => themeBox);

  sl.registerLazySingleton(() => tasksBox);

  sl.registerLazySingleton(() => habitsBox);

  sl.registerLazySingleton(() => foldersBox);

  sl.registerLazySingleton(
    () => FirebaseFirestore.instance,
  );

  sl.registerLazySingleton(
    () => FirebaseAuth.instance,
  );
}
