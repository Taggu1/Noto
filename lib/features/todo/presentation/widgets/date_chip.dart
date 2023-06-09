import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';

class DateChip extends StatelessWidget {
  final void Function()? onDeleted;
  final String label;
  const DateChip({super.key, this.onDeleted, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      deleteIcon: const Icon(Entypo.cancel),
      onDeleted: onDeleted,
      label: Text(
        label,
      ),
      deleteButtonTooltipMessage: '',
    );
  }
}
