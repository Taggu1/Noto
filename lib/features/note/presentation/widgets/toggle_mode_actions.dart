import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';

import '../../../../core/widgets/buttons/custom_elevated_button.dart';
import '../../../../core/widgets/custom_iconbutton_widget.dart';

class ToggleModeActions extends StatelessWidget {
  final List<String> notesIds;
  final VoidCallback offToggleMode;
  final VoidCallback onDelete;
  const ToggleModeActions(
      {super.key,
      required this.notesIds,
      required this.offToggleMode,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: double.infinity,
      color: Theme.of(context).canvasColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomIconButton(
              icon: Icons.keyboard_arrow_left,
              onPressed: () {
                offToggleMode();
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconButton(
                  icon: Entypo.trash,
                  onPressed: () {
                    _removeWidget(notesIds, context, offToggleMode);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _removeWidget(
      List<String> notesIds, BuildContext context, VoidCallback offToggleMode) {
    showDialog(
      context: context,
      builder: (ctx) => CustomAlertDialog(
        onDelete: onDelete,
        text: 'Do u want to delete this?',
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.onDelete,
    required this.text,
  });

  final String text;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        text,
        style:
            Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 20),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        CustomElevatedButton(
          onPressed: onDelete,
          child: const Text("Yes"),
        ),
        CustomElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("No"),
        ),
      ],
    );
  }
}
