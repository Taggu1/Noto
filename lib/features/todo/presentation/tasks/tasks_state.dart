part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TasksInitial extends TasksState {}

class LoadedTasksState extends TasksState {
  final List<AppTask> tasks;

  const LoadedTasksState({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

class LoadingTasksState extends TasksState {}

class ErrorTasksState extends TasksState {
  final String message;

  const ErrorTasksState({required this.message});

  @override
  List<Object> get props => [message];
}
