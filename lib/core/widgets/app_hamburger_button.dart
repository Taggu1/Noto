import 'package:flutter/material.dart';

import 'custom_iconbutton_widget.dart';

class AppHambergerButton extends StatelessWidget {
  const AppHambergerButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      icon: Icons.menu,
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}
