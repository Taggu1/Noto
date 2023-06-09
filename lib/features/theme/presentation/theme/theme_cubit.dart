import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app/core/constants/theme.dart';
import 'package:note_app/features/theme/domain/entities/theme.dart';
import 'package:note_app/features/theme/domain/use_cases/fetch_theme_use_case.dart';
import 'package:note_app/features/theme/domain/use_cases/save_theme_use_case.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final FetchThemeUseCase fetchThemeUseCase;
  final SaveThemeUseCase saveThemeUseCase;
  ThemeCubit(this.fetchThemeUseCase, this.saveThemeUseCase)
      : super(ThemeState(defualtTheme));

  fetchTheme() {
    final theme = fetchThemeUseCase();
    emit(
      theme.fold(
        (failure) => state,
        (theme) => ThemeState(theme),
      ),
    );
  }

  saveTheme({required Theme theme}) {
    final unitOrFailure = saveThemeUseCase(theme: theme);
    print(state.theme == theme);
    emit(
      unitOrFailure.fold(
        (faiure) => state,
        (unit) => ThemeState(theme),
      ),
    );
  }
}
