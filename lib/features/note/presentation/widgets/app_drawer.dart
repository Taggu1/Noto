import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:note_app/core/constants/theme_constants.dart';
import 'package:note_app/core/utils/widgets_extentions.dart';
import 'package:note_app/features/note/presentation/pages/notes_page.dart';
import 'package:note_app/features/theme/presentation/pages/settings_page.dart';

import '../../../../core/widgets/custom_text_button.dart';
import '../../../backup/presentation/pages/backup_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Text(
            "Noto - ノート",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30,
              height: 2,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 50, bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPageButton(context, NotesPage.routeName, "Notes",
                  FontAwesome5.sticky_note, true),
              addVerticalSpace(10),
              _buildPageButton(context, SettingsPage.routeName, "Settings",
                  Icons.settings, false),
              addVerticalSpace(10),
              _buildPageButton(
                  context, BackupPage.routeName, "Backup", Icons.backup, false),
              addVerticalSpace(10),
            ],
          ),
        ),
      ],
    );
  }
}

CustomTextButton _buildPageButton(
    BuildContext context, String routeName, text, IconData icon, bool replace) {
  return CustomTextButton(
    onPressed: () {
      Navigator.of(context).pop();
      _buttonOnPressedFunc(context, routeName, replace);
    },
    text: Text(
      text,
      style: buttonTextStyle,
    ),
    iconData: icon,
  );
}

_buttonOnPressedFunc(BuildContext context, String routeName, bool replace) {
  if (replace) {
    Navigator.of(context).pushReplacementNamed(routeName);
  } else {
    Navigator.of(context).pushNamed(routeName);
  }
}
