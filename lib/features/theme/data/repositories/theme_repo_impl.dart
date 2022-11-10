import 'package:note_app/core/errors/exceptions.dart';
import 'package:note_app/features/theme/data/data_sources/theme_local_db.dart';
import 'package:note_app/features/theme/domain/entities/theme.dart';
import 'package:note_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:note_app/features/theme/domain/repository/theme_repo.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalSource themeLocalDatabase;

  ThemeRepositoryImpl({required this.themeLocalDatabase});
  @override
  Either<Failure, Theme> fetchTheme() {
    try {
      return Right(themeLocalDatabase.fetchTheme());
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Either<Failure, Unit> saveTheme({required Theme theme}) {
    try {
      return Right(themeLocalDatabase.saveTheme(theme: theme));
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }
}
