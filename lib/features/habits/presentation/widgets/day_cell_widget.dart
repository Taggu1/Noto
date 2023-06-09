import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/constants/theme_constants.dart';
import 'package:note_app/features/habits/presentation/habit_bloc/habit_bloc.dart';

class DayCellWidget extends StatelessWidget {
  final DateTime date;
  final Color color;
  final bool selected;
  final bool isFree;
  final Function(BuildContext context, DateTime date, bool isAdd) onTap;
  const DayCellWidget(
      {super.key,
      required this.date,
      required this.color,
      required this.selected,
      required this.onTap,
      required this.isFree});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !isFree ? () => onTap(context, date, !selected) : null,
      child: CircleAvatar(
        backgroundColor:
            isFree ? Colors.grey : color.withOpacity(selected ? 1 : 0.5),
        child: Text(
          date.day.toString(),
          style: const TextStyle(
            color: kBlackColor,
          ),
        ),
      ),
    );
  }
}
