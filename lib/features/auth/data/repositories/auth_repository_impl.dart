import 'package:dartz/dartz.dart';
import 'package:note_app/core/utils/auth_utils.dart';
import 'package:note_app/features/note/domain/repositories/note_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/models/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NotesRepository notesRepository;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.notesRepository,
  });

  @override
  Future<Either<Failure, AppUser>> logIn(
      {required String email, required String password}) async {
    try {
      final user = await authRemoteDataSource.logIn(
        email: email,
        password: password,
      );

      await _sync();

      return Right(user);
    } catch (e) {
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

      await _sync();

      return Right(
        databaseUser,
      );
    } catch (e) {
      return Left(
        AuthFailure(message: mapErrorCodeToMessage(e.toString())),
      );
    }
  }

  @override
  Future<Either<Failure, AppUser?>> fetchUser() async {
    try {
      final user = await authRemoteDataSource.fetchUser();
      return Right(
        user,
      );
    } catch (e) {
      return Left(
        AuthFailure(message: mapErrorCodeToMessage(e.toString())),
      );
    }
  }

  Future<void> _sync() async {
    await notesRepository.syncNotes();
  }
}
