part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class FetchTasksEvent extends TasksEvent {
  final DateTime date;

  const FetchTasksEvent({required this.date});
}

class EditOrAddTaskEvent extends TasksEvent {
  final AppTask task;

  const EditOrAddTaskEvent({required this.task});

  @override
  List<Object> get props => [
        task,
      ];
}

class RemoveTaskEvent extends TasksEvent {
  final String taskId;

  const RemoveTaskEvent({required this.taskId});

  @override
  List<Object> get props => [taskId];
}

class RemoveTasksEvent extends TasksEvent {
  final Map<String, int?> idsMap;

  const RemoveTasksEvent({required this.idsMap});

  @override
  List<Object> get props => [idsMap];
}
