import 'package:dartz/dartz.dart';
import 'package:note_app/core/utils/auth_utils.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/models/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
  });

  @override
  Future<Either<Failure, AppUser>> logIn(
      {required String email, required String password}) async {
    try {
      final user = await authRemoteDataSource.logIn(
        email: email,
        password: password,
      );

      print(user);

      return Right(user);
    } catch (e) {
      print(e);
      return Left(
        AuthFailure(message: mapErrorCodeToMessage(e.toString())),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await authRemoteDataSource.signOut();

      return const Right(
        unit,
      );
    } catch (e) {
      return Left(
        AuthFailure(message: mapErrorCodeToMessage(e.toString())),
      );
    }
  }

  @override
  Future<Either<Failure, AppUser>> signUp(
      {required String password, required String email}) async {
    try {
      final databaseUser = await authRemoteDataSource.signUp(
        email: email,
        password: password,
      );

      return Right(
        databaseUser,
      );
    } catch (e) {
      print(e);
      return Left(
        AuthFailure(message: mapErrorCodeToMessage(e.toString())),
      );
    }
  }

  @override
  Future<Either<Failure, AppUser?>> fetchUser() async {
    try {
      final user = await authRemoteDataSource.fetchUser();
      print(user);
      return Right(
        user,
      );
    } catch (e) {
      print(e);
      return Left(
        AuthFailure(message: mapErrorCodeToMessage(e.toString())),
      );
    }
  }
}
