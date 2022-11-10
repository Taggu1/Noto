part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final Theme theme;
  const ThemeState(this.theme);

  @override
  List<Object> get props => [theme];
}
