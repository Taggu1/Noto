import 'package:flutter/material.dart';
import 'package:note_app/features/theme/presentation/widgets/settings_tile.dart';

import '../widgets/switch_theme_button.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = "/settings";
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: const Column(
        children: [
          SettingsTile(
            titleText: "Theme mode",
            subTitleText: "toggle between dark and light mode",
            trailing: SwitchThemeButton(),
          ),
          // SettingsTile(
          //   titleText: "Select theme",
          //   subTitleText: "choose from a variety of beautiful themes",
          //   onbuttonTap: () {
          //     Navigator.of(context).pushNamed(SchemePage.routeName);
          //   },
          //   trailing: const Icon(
          //     Icons.arrow_right,
          //   ),
          // )
        ],
      ),
    );
  }
}
