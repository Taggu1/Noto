import 'package:flutter/material.dart';

import '../../../../core/utils/widgets_extentions.dart';
import '../../../todo/presentation/widgets/sheet_title_text.dart';

class AuthFormTitle extends StatelessWidget {
  final bool isSignup;
  final void Function(bool)? onChanged;
  const AuthFormTitle({super.key, required this.isSignup, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SheetTitleText(
            text: isSignup ? "Signup" : "Login",
            fontSize: 25,
          ),
          addHorizontalSpace(15),
          Switch(value: isSignup, onChanged: onChanged),
        ],
      ),
    );
  }
}
