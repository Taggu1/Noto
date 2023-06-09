import 'package:flutter/cupertino.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:note_app/core/utils/date_utils.dart';
import 'package:note_app/features/todo/domain/entities/task.dart';
import 'package:note_app/features/todo/presentation/widgets/task_widget.dart';

class TasksWidget extends StatelessWidget {
  final List<AppTask> tasks;
  final void Function(String taksId, int? hashCode) toggleHoldMode;
  final List<String> toggledTasksIndexes;
  final bool toggledMode;
  final DateTime date;
  const TasksWidget(
      {super.key,
      required this.tasks,
      required this.toggleHoldMode,
      required this.toggledTasksIndexes,
      required this.toggledMode,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: GroupedListView(
          elements: tasks,
          groupBy: (element) =>
              element.doneDates.contains(date.toDateString()).toString(),
          groupSeparatorBuilder: (String groupByValue) {
            return Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  groupByValue == "false" ? "Not done" : "Done",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            );
          },
          order: GroupedListOrder.ASC,
          itemBuilder: (context, AppTask task) => TaskWidget(
            task: task,
            toggleHoldMode: toggleHoldMode,
            isToggled: toggledTasksIndexes.contains(
              task.id,
            ),
            toggledMode: toggledMode,
            date: date,
            done: task.doneDates.contains(date.toDateString()),
          ),
        ),
      ),
    );
    // return Expanded(
    //   child: ListView.builder(
    //     itemCount: tasks.length,
    //     itemBuilder: (context, index) {
    //       return TaskWidget(appTask: tasks[index]);
    //     },
    //   ),
    // );
  }
}
