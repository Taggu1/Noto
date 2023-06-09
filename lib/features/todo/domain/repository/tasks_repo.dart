import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/task.dart';

abstract class TasksRepository {
  Future<Either<Failure, List<AppTask>>> fetchTasks({DateTime? date});
  Future<Either<Failure, Unit>> addOrEditTasks({required AppTask task});
  Future<Either<Failure, Unit>> removeTask({required String taskId});
}
