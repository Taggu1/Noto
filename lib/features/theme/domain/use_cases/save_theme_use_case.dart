import 'package:dartz/dartz.dart';
import 'package:note_app/features/theme/domain/repository/theme_repo.dart';

import '../../../../core/errors/failures.dart';
import '../entities/theme.dart';

class SaveThemeUseCase {
  final ThemeRepository repository;

  SaveThemeUseCase(this.repository);

  Either<Failure, Unit> call({required Theme theme}) {
    return repository.saveTheme(theme: theme);
  }
}
