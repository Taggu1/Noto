import 'package:dartz/dartz.dart';
import 'package:note_app/features/backup/domain/entities/backup_data.dart';
import 'package:note_app/features/backup/domain/repository/backup_repository.dart';

import '../../../../core/errors/failures.dart';

class BackupUseCase {
  final BackupRepository repository;

  BackupUseCase({required this.repository});

  Future<Either<Failure, Unit>> call({required BackUpData backUpData}) async {
    return await repository.backup(backUpData: backUpData);
  }
}
