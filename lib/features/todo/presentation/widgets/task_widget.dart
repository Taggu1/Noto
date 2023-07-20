import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/core/utils/date_utils.dart';
import 'package:note_app/core/utils/string.dart';

import '../../../../core/constants/theme_constants.dart';
import '../../domain/entities/task.dart';
import '../tasks/tasks_bloc.dart';
import 'add_item_sheet.dart';

class TaskWidget extends StatelessWidget {
  final AppTask task;
  final void Function(String taksId, int? intId) toggleHoldMode;
  final bool toggledMode;
  final DateTime date;
  final bool done;
  final bool isToggled;
  const TaskWidget(
      {super.key,
      required this.task,
      required this.toggleHoldMode,
      required this.toggledMode,
      required this.isToggled,
      required this.date,
      required this.done});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: toggledMode
            ? () => toggleHoldMode(task.id, task.hashCode)
            : () => _toggleDone(context),
        onLongPress: () => toggleHoldMode(task.id, task.hashCode),
        child: AnimatedOpacity(
          opacity: done ? 0.2 : 1,
          duration: const Duration(milliseconds: 200),
          child: AnimatedContainer(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: isToggled
                  ? Border.all(
                      width: 2,
                      color: Theme.of(context).colorScheme.onSurface,
                    )
                  : null,
              color: task.color?.toMaterialColor(),
            ),
            duration: const Duration(milliseconds: 50),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: done ? Colors.red : Colors.black,
                    ),
                    onPressed: () => _showEditSheet(context),
                  ),
                  TaskTextWidget(
                    title: task.title,
                    reminder: task.reminder,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showEditSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (s) => AddItemSheet(
              isAdd: false,
              item: task,
              isTask: true,
            ));
  }

  void _toggleDone(BuildContext context) {
    List<String> doneDays = task.doneDates;
    final stringDate = date.toDateString();
    final done = doneDays.contains(stringDate);
    if (done) {
      doneDays.remove(stringDate);
    } else {
      doneDays = [...task.doneDates, date.toDateString()];
    }

    BlocProvider.of<TasksBloc>(context).add(
      EditOrAddTaskEvent(
        task: task.copyWith(
          doneDates: doneDays,
        ),
      ),
    );
    BlocProvider.of<TasksBloc>(context).add(
      FetchTasksEvent(
        date: date,
      ),
    );
  }
}

class TaskTextWidget extends StatelessWidget {
  const TaskTextWidget({
    super.key,
    required this.title,
    this.reminder,
  });

  final String title;
  final String? reminder;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TaskTitleTextWidget(title: title),
            if (reminder != null) TaskTimeTextWidget(reminder: reminder),
          ],
        ),
      ),
    );
  }
}

class TaskTimeTextWidget extends StatelessWidget {
  const TaskTimeTextWidget({
    super.key,
    required this.reminder,
  });

  final String? reminder;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      reminder!,
      style: GoogleFonts.robotoCondensed(
        fontSize: 16,
        color: DateTime.now().isAfterDate(
          taskDateFromString(dateTimeString: reminder!),
        )
            ? Colors.teal
            : kBlackColor,
      ),
      textAlign: TextAlign.start,
      maxLines: 5,
    );
  }
}

class TaskTitleTextWidget extends StatelessWidget {
  const TaskTitleTextWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      title,
      style: GoogleFonts.robotoCondensed(
        fontSize: 20,
        color: kBlackColor,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.start,
      maxLines: 5,
    );
  }
}
