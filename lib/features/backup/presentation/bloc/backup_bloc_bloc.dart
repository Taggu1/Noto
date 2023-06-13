import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app/features/backup/domain/entities/backup_data.dart';
import 'package:note_app/features/backup/domain/use_cases/backup_use_case.dart';
import 'package:note_app/features/backup/domain/use_cases/restore_use_case.dart';

import '../../../../../core/errors/failures.dart';

part 'backup_bloc_event.dart';
part 'backup_bloc_state.dart';

class BackupBlocBloc extends Bloc<BackupBlocEvent, BackupBlocState> {
  final BackupUseCase backupUseCase;
  final RestoreUseCase restoreUseCase;
  BackupBlocBloc({required this.backupUseCase, required this.restoreUseCase})
      : super(BackupBlocInitial()) {
    on<BackupBlocEvent>((event, emit) async {
      if (event is BackupEvent) {
        emit(LoadingBackupState());

        final responseOrFailure =
            await backupUseCase(backUpData: event.backUpData);

        emit(_mapResponseOrFailureToState(responseOrFailure));
      } else if (event is RestoreEvent) {
        emit(LoadingRestoringState());
        final responseOrFailure =
            await restoreUseCase(backUpData: event.backUpData);
        emit(_mapResponseOrFailureToState(responseOrFailure));
      }
    });
  }

  BackupBlocState _mapResponseOrFailureToState(Either<Failure, Unit> response) {
    return response.fold(
      (left) => BackupBlocInitial(),
      (right) => SuccessfulBackupState(),
    );
  }
}
