import 'package:flutter/material.dart';

import '../../../../core/widgets/app_hamburger_button.dart';

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
