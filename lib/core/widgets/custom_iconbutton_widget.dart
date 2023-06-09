import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final Color? buttonColor;
  final Color? iconColor;
  final VoidCallback? onLongPress;
  const CustomIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.buttonColor,
    this.iconColor,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
        onLongPress: onLongPress,
        child: IconButton(
          splashRadius: 22,
          onPressed: () => onPressed(),
          icon: Icon(
            icon,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
