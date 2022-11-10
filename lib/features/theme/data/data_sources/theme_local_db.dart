import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:note_app/features/theme/domain/entities/theme.dart';

import '../../../../core/constants/theme.dart';

abstract class ThemeLocalSource {
  Theme fetchTheme();
  Unit saveTheme({required Theme theme});
}

class ThemeLocalSourceImpl extends ThemeLocalSource {
  final Box<Theme> hiveBox;

  ThemeLocalSourceImpl({required this.hiveBox});

  @override
  Theme fetchTheme() {
    final theme = hiveBox.get("theme");

    if (theme == null) {
      hiveBox.put("theme", defualtTheme);
      return defualtTheme;
    }
    return theme;
  }

  @override
  Unit saveTheme({required Theme theme}) {
    hiveBox.put("theme", theme);
    return unit;
  }
}
