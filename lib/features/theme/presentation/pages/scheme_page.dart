import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/utils/color_utils.dart';
import 'package:note_app/core/widgets/buttons/custom_elevated_button.dart';
import 'package:note_app/core/widgets/custom_text_button.dart';
import 'package:note_app/features/theme/domain/entities/theme.dart' as et;
import 'package:note_app/features/theme/presentation/theme/theme_cubit.dart';
import 'package:note_app/features/theme/presentation/widgets/scheme_photo_widget.dart';

class SchemePage extends StatefulWidget {
  static const routeName = "/scheme";
  const SchemePage({super.key});

  @override
  State<SchemePage> createState() => _SchemePageState();
}

class _SchemePageState extends State<SchemePage> {
  int currentThemeIndex = 0;
  final _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scheme"),
      ),
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final theme = state.theme;
          return Column(
            children: [
              Container(
                height: size.height * 0.7,
                child: PageView(
                  controller: _pageController,
                  children: [
                    SchemePhotoWidget(themeNum: 0, isDark: theme.isDarkMode),
                    SchemePhotoWidget(themeNum: 1, isDark: theme.isDarkMode),
                    SchemePhotoWidget(themeNum: 2, isDark: theme.isDarkMode),
                  ],
                  onPageChanged: (value) {
                    currentThemeIndex = value;
                    setState(() {});
                  },
                ),
              ),
              CustomElevatedButton(
                onPressed: theme.flexThemeIndex == currentThemeIndex
                    ? null
                    : () {
                        _onButtonPressed(context, theme, currentThemeIndex);
                      },
                child: Text(
                  theme.flexThemeIndex == currentThemeIndex
                      ? "Current Scheme"
                      : "Select scheme",
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onButtonPressed(
      BuildContext context, et.Theme theme, int currentValue) {
    final newTheme =
        et.Theme(isDarkMode: theme.isDarkMode, flexThemeIndex: currentValue);
    BlocProvider.of<ThemeCubit>(context).saveTheme(theme: newTheme);
  }
}
