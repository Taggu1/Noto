part of 'backup_bloc_bloc.dart';

abstract class BackupBlocEvent extends Equatable {
  const BackupBlocEvent();

  @override
  List<Object> get props => [];
}

class BackupEvent extends BackupBlocEvent {
  final BackUpData backUpData;

  const BackupEvent({required this.backUpData});

  @override
  List<Object> get props => [backUpData];
}

class RestoreEvent extends BackupBlocEvent {
  final BackUpData backUpData;

  const RestoreEvent({required this.backUpData});

  @override
  List<Object> get props => [backUpData];
}
