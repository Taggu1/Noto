import 'package:flutter/material.dart';
import 'package:note_app/core/utils/widgets_extentions.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? iconData;
  final Size minimumsize;
  final Text text;

  const CustomTextButton({
    required this.onPressed,
    this.iconData,
    required this.text,
    this.minimumsize = const Size(400, 40),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          alignment: Alignment.centerLeft,
          minimumSize: minimumsize,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (iconData != null)
                Icon(
                  iconData,
                ),
              addHorizontalSpace(15),
              text,
            ],
          ),
        ));
  }
}
