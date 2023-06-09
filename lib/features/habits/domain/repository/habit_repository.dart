import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/habit.dart';

abstract class HabitRepository {
  Future<Either<Failure, List<Habit>>> fetchHabits();
  Future<Either<Failure, Unit>> addOrEditHabit({required Habit habit});
  Future<Either<Failure, Unit>> removeHabit({required String habitId});
}
