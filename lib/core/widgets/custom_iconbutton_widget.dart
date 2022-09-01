import 'package:flutter/material.dart';

import '../constants/theme_constants.dart';

class CustomIconButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final Color buttonColor;
  const CustomIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.buttonColor = kGreyColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: IconButton(
        splashRadius: 22,
        onPressed: () => onPressed(),
        icon: Icon(
          icon,
          color: kWhiteColor,
        ),
      ),
    );
  }
}
