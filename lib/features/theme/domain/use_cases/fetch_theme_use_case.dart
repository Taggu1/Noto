import 'package:dartz/dartz.dart';
import 'package:note_app/features/theme/domain/repository/theme_repo.dart';

import '../../../../core/errors/failures.dart';
import '../entities/theme.dart';

class FetchThemeUseCase {
  final ThemeRepository repository;

  FetchThemeUseCase(this.repository);

  Either<Failure, Theme> call() {
    return repository.fetchTheme();
  }
}
