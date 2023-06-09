import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/app_user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AppUser>> signUp(
      {required String password, required String email});
  Future<Either<Failure, AppUser>> logIn(
      {required String email, required String password});
  Future<Either<Failure, Unit>> signOut();
  Future<Either<Failure, AppUser?>> fetchUser();
}
