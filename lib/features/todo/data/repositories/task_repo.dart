import 'package:dartz/dartz.dart';
import 'package:note_app/core/data_sources/local_data_source.dart';
import 'package:note_app/core/errors/failures.dart';
import 'package:note_app/core/utils/date_utils.dart';
import 'package:note_app/features/todo/domain/entities/task.dart';
import 'package:note_app/features/todo/domain/repository/tasks_repo.dart';

class TasksRepositoryImpl extends TasksRepository {
  final LocalDataSource<AppTask> localDataSource;

  TasksRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Unit>> addOrEditTasks({required AppTask task}) async {
    try {
      await localDataSource.addItem(item: task);

      return const Right(unit);
    } catch (e) {
      print(e);
      return Left(
        DatabaseFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, List<AppTask>>> fetchTasks({DateTime? date}) async {
    try {
      var tasks = await localDataSource.fetchItems();

      if (date != null) {
        tasks = tasks
            .where(
              (task) =>
                  task.createdAt == date.toDateString() ||
                  task.repeatedDays.contains(
                    date.weekday,
                  ),
            )
            .toList();
      }
      return Right(tasks);
    } catch (e) {
      return Left(
        DatabaseFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> removeTask({required String taskId}) async {
    try {
      await localDataSource.removeItem(
        itemId: taskId,
      );

      return const Right(unit);
    } catch (e) {
      return Left(
        DatabaseFailure(),
      );
    }
  }
}
