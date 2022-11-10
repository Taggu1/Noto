import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

part 'theme.g.dart';

@HiveType(typeId: 11)
class Theme extends Equatable with HiveObjectMixin {
  @HiveField(0)
  final bool isDarkMode;
  @HiveField(1)
  final int flexThemeIndex;

  Theme({
    required this.isDarkMode,
    required this.flexThemeIndex,
  });

  @override
  List<Object?> get props => [isDarkMode, flexThemeIndex];
}
