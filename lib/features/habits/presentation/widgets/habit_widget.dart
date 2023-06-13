import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/constants/colors.dart';
import 'package:note_app/core/utils/date_utils.dart';
import 'package:note_app/core/utils/string.dart';
import 'package:note_app/features/habits/presentation/habit_bloc/habit_bloc.dart';
import 'package:note_app/features/habits/presentation/widgets/day_cell_widget.dart';

import '../../../todo/presentation/widgets/add_item_sheet.dart';
import '../../domain/models/habit.dart';

class HabitWidget extends StatelessWidget {
  final Habit habit;
  const HabitWidget({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 22,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onLongPress: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (s) => AddItemSheet<Habit>(
              isTask: false,
              item: habit,
              isAdd: false,
            ),
          );
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: kSurfaceColor,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Text(
                        habit.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: false,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "${habit.doneDates.length}x",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    7,
                    (index) {
                      final date = DateTime.now().subtract(
                        Duration(
                          days: 6 - index,
                        ),
                      );
                      return DayCellWidget(
                        date: date,
                        color: habit.color.toMaterialColor(),
                        selected: habit.doneDates.contains(
                          date.toDateString(),
                        ),
                        onTap: _onCellTap,
                        isFree: habit.habitDays.contains(
                          date.weekday,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onCellTap(BuildContext context, DateTime date, bool isAdd) {
    BlocProvider.of<HabitBloc>(context).add(
      EditOrAddHabitEvent(
        habit: isAdd
            ? habit.copyWith(
                doneDates: habit.doneDates
                  ..add(
                    date.toDateString(),
                  ),
              )
            : habit.copyWith(
                doneDates: habit.doneDates
                  ..removeWhere(
                    (doneDate) => doneDate == date.toDateString(),
                  ),
              ),
      ),
    );

    BlocProvider.of<HabitBloc>(context).add(FetchHabitsEvent());
  }
}
