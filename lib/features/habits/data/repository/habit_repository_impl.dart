import 'package:dartz/dartz.dart';
import 'package:note_app/features/habits/domain/models/habit.dart';

import '../../../../core/data_sources/local_data_source.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repository/habit_repository.dart';

class HabitRepositoryImpl implements HabitRepository {
  final LocalDataSource<Habit> localDataSourceImpl;

  HabitRepositoryImpl({
    required this.localDataSourceImpl,
  });

  @override
  Future<Either<Failure, List<Habit>>> fetchHabits() async {
    try {
      final habits = await localDataSourceImpl.fetchItems();
      return Right(habits);
    } on DatabaseException {
      return Left(
        DatabaseFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> removeHabit({required String habitId}) async {
    try {
      final response = await localDataSourceImpl.removeItem(itemId: habitId);
      return Right(response);
    } on DatabaseException {
      return Left(
        DatabaseFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> addOrEditHabit({required Habit habit}) async {
    try {
      Unit response;

      response = await localDataSourceImpl.addItem(item: habit);

      return Right(response);
    } on DatabaseException {
      return Left(
        DatabaseFailure(),
      );
    }
  }
}
