import 'package:dartz/dartz.dart';
import 'package:note_app/core/errors/failures.dart';
import 'package:note_app/features/theme/domain/entities/theme.dart';

abstract class ThemeRepository {
  Either<Failure, Theme> fetchTheme();
  Either<Failure, Unit> saveTheme({required Theme theme});
}
