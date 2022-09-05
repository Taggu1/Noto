part of 'backup_bloc_bloc.dart';

abstract class BackupBlocState extends Equatable {
  const BackupBlocState();

  @override
  List<Object> get props => [];
}

class BackupBlocInitial extends BackupBlocState {}

class SuccessfulBackupState extends BackupBlocState {}
