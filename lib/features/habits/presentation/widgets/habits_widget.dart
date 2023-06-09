import 'package:flutter/material.dart';
import 'package:note_app/features/habits/presentation/widgets/habit_widget.dart';

import '../../domain/models/habit.dart';

class HabitsWidget extends StatelessWidget {
  final List<Habit> habits;
  const HabitsWidget({super.key, required this.habits});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 20,
        ),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return HabitWidget(
              habit: habits[index],
            );
          },
          itemCount: habits.length,
        ),
      ),
    );
  }
}
