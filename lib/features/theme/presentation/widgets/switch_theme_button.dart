import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/theme/domain/entities/theme.dart' as et;
import 'package:note_app/features/theme/presentation/theme/theme_cubit.dart';

class SwitchThemeButton extends StatelessWidget {
  const SwitchThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final theme = state.theme;
        return IconButton(
          icon: Icon(theme.isDarkMode ? Icons.light_mode : Icons.dark_mode),
          onPressed: () {
            BlocProvider.of<ThemeCubit>(context).saveTheme(
              theme: et.Theme(
                isDarkMode: !theme.isDarkMode,
                flexThemeIndex: theme.flexThemeIndex,
              ),
            );
          },
        );
      },
    );
  }
}
