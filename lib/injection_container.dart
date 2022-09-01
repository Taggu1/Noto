import 'dart:ffi';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
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

  // UseCase
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

  sl.registerLazySingleton<NotesRepository>(
    () => NoteRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // DataSources

  sl.registerLazySingleton<NoteLocalDataSource>(
    () => NoteLocalDataSourceImpl(
      hiveBox: sl(),
    ),
  );

  // External
  final notesBox = await Hive.openBox<Note>('notes');
  sl.registerLazySingleton(() => notesBox);
}
