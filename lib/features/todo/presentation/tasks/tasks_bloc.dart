import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app/features/todo/domain/repository/tasks_repo.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TasksRepository tasksRepository;
  TasksBloc({required this.tasksRepository}) : super(TasksInitial()) {
    on<TasksEvent>((event, emit) async {
      if (event is FetchTasksEvent) {
        emit(LoadingTasksState());
        final tasksOrFailure =
            await tasksRepository.fetchTasks(date: event.date);

        emit(_tasksOrFailureToNoteState(tasksOrFailure));
      } else if (event is EditOrAddTaskEvent && state is LoadedTasksState) {
        final currentState = state as LoadedTasksState;
        final unitOrFailure = await tasksRepository.addOrEditTasks(
          task: event.task,
        );

        emit(
          _unitOrFailureToNoteState(
              unitOrFailure, event.task, currentState.tasks),
        );
      } else if (event is RemoveTaskEvent && state is LoadedTasksState) {
        final currentState = state as LoadedTasksState;
        await tasksRepository.removeTask(taskId: event.taskId);

        emit(
          LoadedTasksState(
            tasks: currentState.tasks
              ..removeWhere(
                (note) => note.id == event.taskId,
              ),
          ),
        );
      } else if (event is RemoveTasksEvent) {
        for (final id in event.idsMap.keys) {
          await tasksRepository.removeTask(taskId: id);
        }
      }
    });
  }

  TasksState _tasksOrFailureToNoteState(
    Either<Failure, List<AppTask>> notesOrFailure,
  ) {
    return notesOrFailure.fold(
      (failure) => const ErrorTasksState(
        message: "Something happened while loading the tasks",
      ),
      (tasks) => LoadedTasksState(tasks: tasks),
    );
  }

  TasksState _unitOrFailureToNoteState(Either<Failure, Unit> unitOrFailure,
      AppTask appTask, List<AppTask> stateTasks) {
    return unitOrFailure.fold(
      (faliure) => const ErrorTasksState(
          message: "Something worng happend while loading the tasks"),
      (unit) {
        return state;
      },
    );
  }
}
