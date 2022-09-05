import 'dart:ffi';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:note_app/features/backup/data/data_sources/backup_local_data_source.dart';
import 'package:note_app/features/backup/data/repository/backup_repository_impl.dart';
import 'package:note_app/features/backup/domain/repository/backup_repository.dart';
import 'package:note_app/features/backup/domain/use_cases/backup_use_case.dart';
import 'package:note_app/features/backup/domain/use_cases/restore_use_case.dart';
import 'package:note_app/features/backup/presentation/bloc/backup_bloc_bloc.dart';
import 'package:note_app/features/note/data/data_sources/local_data_source.dart';
import 'package:note_app/features/note/data/repositories/note_repository_impl.dart';
import 'package:note_app/features/note/domain/entities/note.dart';
import 'package:note_app/features/note/domain/repositories/note_repository.dart';
import 'package:note_app/features/note/domain/use_cases/add_note_use_case.dart';
import 'package:note_app/features/note/domain/use_cases/fetch_notes_use_case.dart';
import 'package:note_app/features/note/domain/use_cases/re_order_notes_use_case.dart';
import 'package:note_app/features/note/domain/use_cases/remove_note_use_case.dart';
import 'package:note_app/features/note/presentation/note/note_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/models/hive_offset.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features

  // Bloc

  sl.registerFactory(
    () => NoteBloc(
      fetchNotesUseCase: sl(),
      removeNoteUseCase: sl(),
      addOrEditNoteUseCase: sl(),
      reOrderNotesUseCase: sl(),
    ),
  );

  sl.registerFactory(() => BackupBlocBloc(
        backupUseCase: sl(),
        restoreUseCase: sl(),
      ));

  // UseCase

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

  sl.registerLazySingleton<BackupRepository>(
    () => BackUpRepositoyImpl(
      backupLocalDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<NotesRepository>(
    () => NoteRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // DataSources

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

  // External
  final dir = await getApplicationDocumentsDirectory();

  Hive.init("${dir.path}/notes/");

  Hive.registerAdapter(HiveOffsetAdapter());
  Hive.registerAdapter(NoteAdapter());
  final notesBox = await Hive.openBox<Note>('notes');
  sl.registerLazySingleton(() => notesBox);
}
