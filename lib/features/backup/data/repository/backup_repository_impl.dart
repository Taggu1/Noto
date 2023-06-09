import 'package:note_app/features/backup/data/data_sources/backup_local_data_source.dart';
import 'package:note_app/features/backup/domain/entities/backup_data.dart';
import 'package:note_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:note_app/features/backup/domain/repository/backup_repository.dart';

class BackUpRepositoyImpl implements BackupRepository {
  final BackupLocalDataSource backupLocalDataSource;

  BackUpRepositoyImpl({
    required this.backupLocalDataSource,
  });

  @override
  Future<Either<Failure, Unit>> backup({required BackUpData backUpData}) async {
    try {
      final response =
          await backupLocalDataSource.backup(backUpData: backUpData);
      return Right(response);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> restore(
      {required BackUpData backUpData}) async {
    try {
      final response =
          await backupLocalDataSource.restore(backUpData: backUpData);
      return Right(response);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }
}
