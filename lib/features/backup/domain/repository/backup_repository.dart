import 'package:dartz/dartz.dart';
import 'package:note_app/core/errors/failures.dart';
import 'package:note_app/features/backup/domain/entities/backup_data.dart';

abstract class BackupRepository {
  Future<Either<Failure, Unit>> backup({required BackUpData backUpData});
  Future<Either<Failure, Unit>> restore({required BackUpData backUpData});
}
