import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/core/utils/date_utils.dart';

class MyDayWidget extends StatelessWidget {
  final void Function() onDateTapped;
  final DateTime date;
  const MyDayWidget(
      {super.key, required this.onDateTapped, required this.date});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onDateTapped(),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 15,
          right: 15,
        ),
        child: Column(
          children: [
            const Text(
              "My day",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              date.toDateString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
