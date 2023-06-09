import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'theme.g.dart';

@HiveType(typeId: 11)
class Theme extends Equatable with HiveObjectMixin {
  @HiveField(0)
  final bool isDarkMode;

  Theme({
    required this.isDarkMode,
  });

  @override
  List<Object?> get props => [isDarkMode];

  static of(BuildContext context) {}
}
