import 'package:flutter/material.dart';
import 'package:note_app/features/note/presentation/widgets/search_bar.dart';

import '../../../../core/constants/theme_constants.dart';
import '../../../../core/widgets/app_hamburger_button.dart';
import '../../../../core/widgets/custom_iconbutton_widget.dart';

class NotesPageAppbar extends StatelessWidget {
  const NotesPageAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.medium(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      leading: AppHambergerButton(),
      title: Text(
        "Your notes",
      ),
      centerTitle: true,
      actions: [],
    );
  }
}
