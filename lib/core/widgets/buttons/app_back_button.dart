import 'package:flutter/material.dart';

import '../custom_iconbutton_widget.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      icon: Icons.arrow_back,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
