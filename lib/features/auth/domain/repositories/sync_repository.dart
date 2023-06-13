import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class SyncRepository {
  Future<Either<Failure, Unit?>> syncRemoteAndLocal();
}
