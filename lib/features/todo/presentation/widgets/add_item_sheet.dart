import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:note_app/core/utils/color_utils.dart';
import 'package:note_app/core/utils/date_utils.dart';
import 'package:note_app/core/utils/string.dart';
import 'package:note_app/core/widgets/custom_iconbutton_widget.dart';
import 'package:note_app/features/habits/domain/models/habit.dart';
import 'package:note_app/features/note/presentation/widgets/select_note_color_widget.dart';
import 'package:note_app/features/note/presentation/widgets/toggle_mode_actions.dart';
import 'package:note_app/features/todo/domain/entities/task.dart';
import 'package:note_app/features/todo/presentation/cubit/task_page_date_cubit.dart';
import 'package:note_app/features/todo/presentation/tasks/tasks_bloc.dart';
import 'package:note_app/features/todo/presentation/widgets/date_chip.dart';
import 'package:note_app/features/todo/presentation/widgets/select_days_widget.dart';
import 'package:note_app/features/todo/presentation/widgets/sheet_title_row.dart';
import 'package:note_app/features/todo/presentation/widgets/sheet_text_field.dart';
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart';

import '../../../habits/presentation/habit_bloc/habit_bloc.dart';

class AddItemSheet<T> extends StatefulWidget {
  final bool isAdd;
  final T? item;
  final bool isTask;
  const AddItemSheet(
      {super.key, this.isAdd = true, this.item, required this.isTask});

  @override
  State<AddItemSheet> createState() => _AddItemSheetState();
}

class _AddItemSheetState extends State<AddItemSheet> {
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  late DateTime _date;
  @override
  void initState() {
    super.initState();
    _date = BlocProvider.of<TaskPageDateCubit>(context).state.dateTime;
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    if (widget.item != null && !widget.isAdd) {
      switch (widget.item) {
        case AppTask():
          setOldTask(widget.item);
        case Habit():
          setOldHabit(widget.item);
      }
    }
  }

  void setOldTask(AppTask task) {
    _titleController.text = task.title;
    _reminderDate = task.reminder != null
        ? dateTimeFromString(dateTimeString: task.reminder!)
        : null;
    _selectedColor = task.color?.toMaterialColor();
    _id = task.id;
    _descriptionController.text = task.description ?? "";
    _repeated = task.repeated;
    _selectedReapeatedDays = task.repeatedDays;
  }

  void setOldHabit(Habit habit) {
    _time = timeFromSting(string: habit.time);
    _selectedReapeatedDays = habit.habitDays;
    _titleController.text = habit.name;
    _selectedColor = habit.color.toMaterialColor();
  }

  Time _time = Time(hour: 12, minute: 0);
  bool _repeated = false;
  String? _id;
  DateTime? _reminderDate;
  late TextEditingController _descriptionController;
  late TextEditingController _titleController;
  Color? _selectedColor;
  List<int> _selectedReapeatedDays = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SheetTitleRow(
                text: widget.isTask ? "Add To-do" : "Add habit",
                add: _add,
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SheetTextField(
                    hintText:
                        widget.isTask ? "New To-do title" : "New habit name",
                    controller: _titleController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (widget.item is AppTask || widget.isTask)
                    SheetTextField(
                      hintText: "New To-do Description",
                      controller: _descriptionController,
                      borderSize: BorderSide.none,
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _buildActionsRow(context),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }

  Row _buildActionsRow(BuildContext context) {
    return Row(
      children: [
        if (widget.item is AppTask || widget.isTask)
          IconButton(
            onPressed: () => _addRemainder(),
            icon: const Icon(FontAwesome5.bell),
          ),
        if (widget.item is Habit || !widget.isTask)
          IconButton(
            onPressed: () => _addTime(),
            icon: const Icon(FontAwesome5.clock),
          ),
        const SizedBox(
          width: 5,
        ),
        IconButton(
          onPressed: () => _selectColor(),
          icon: Icon(
            Icons.colorize,
            color: _selectedColor,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        if (widget.item != null)
          CustomIconButton(
            onPressed: () => _deleteItem(context),
            icon: Entypo.trash,
          ),
        const SizedBox(
          width: 5,
        ),
        // ChoiceChip(
        //   label: const Text("Repeated"),
        //   selected: _repeated,
        //   onSelected: (value) {
        //     setState(() {
        //       _repeated = value;
        //     });
        //   },
        // ),
        IconButton(
          onPressed: () => _repeatedDays(),
          icon: Icon(
            widget.isTask ? Icons.repeat : Icons.free_cancellation,
          ),
        ),

        const SizedBox(
          width: 20,
        ),
        if (_reminderDate != null)
          DateChip(
            label: _reminderDate!.toDateString(),
            onDeleted: () {
              setState(() {
                _reminderDate = null;
              });
            },
          ),
      ],
    );
  }

  void _addTime() {
    Navigator.of(context).push(
      showPicker(
        context: context,
        value: _time,
        onChange: (time) {
          setState(() {
            _time = time;
          });
        },
      ),
    );
  }

  void _add(BuildContext context, bool pop) {
    if (_titleController.text.isNotEmpty) {
      if (widget.isTask || widget.item is AppTask) {
        _addTask(context, widget.item as AppTask?);
      } else if (!widget.isTask || widget.item is Habit) {
        _addHabit(context, widget.item as Habit?);
      }
    }
    if (pop) Navigator.of(context).pop();
  }

  void _addTask(BuildContext context, AppTask? oldTask) {
    if (_titleController.text.isNotEmpty) {
      BlocProvider.of<TasksBloc>(context).add(
        EditOrAddTaskEvent(
          task: AppTask(
            doneDates: oldTask?.doneDates ?? [],
            title: _titleController.text,
            reminder: _reminderDate?.toDateString(),
            color: _selectedColor?.toString() ?? getRandomColor().toString(),
            id: _id ?? const Uuid().v4(),
            createdAt: oldTask?.createdAt ??
                _reminderDate?.toDateString() ??
                _date.toDateString(),
            description: _descriptionController.text,
            repeated: _repeated,
            repeatedDays: _selectedReapeatedDays,
          ),
        ),
      );
      BlocProvider.of<TasksBloc>(context).add(FetchTasksEvent(date: _date));
    }
  }

  void _addHabit(BuildContext context, Habit? oldHabit) {
    BlocProvider.of<HabitBloc>(context).add(
      EditOrAddHabitEvent(
        habit: Habit(
          time: dateTimeFromTime(time: _time).toDateTimeString(),
          createdAt: DateTime.now().toDateTimeString(),
          doneDates: oldHabit?.doneDates ?? [],
          name: _titleController.text,
          color: _selectedColor?.toString() ?? getRandomColor().toString(),
          habitDays: _selectedReapeatedDays,
          id: oldHabit?.id ?? const Uuid().v4(),
        ),
      ),
    );
    BlocProvider.of<HabitBloc>(context).add(
      FetchHabitsEvent(),
    );
  }

  void _repeatedDays() {
    showModalBottomSheet(
        context: context,
        constraints: const BoxConstraints(
          maxWidth: 900,
        ),
        builder: (ctx) {
          return SelectDaysWidget(
            addDay: _addOrRemoveRepeatedDay,
            selectedReapeatedDays: _selectedReapeatedDays,
            selectAll: _selectAllDays,
            title: widget.isTask ? "Add repeated days" : "Add free days",
          );
        });
  }

  void _selectAllDays(bool add) {
    Function eq = const ListEquality().equals;

    if (!eq(_selectedReapeatedDays, mapWeekDayNumToString.keys.toList())) {
      _selectedReapeatedDays = mapWeekDayNumToString.keys.toList();
    } else {
      _selectedReapeatedDays = [];
    }
    setState(() {});
  }

  void _addOrRemoveRepeatedDay(int repeatedDay, bool add) {
    if (add || !_selectedReapeatedDays.contains(repeatedDay)) {
      _selectedReapeatedDays.add(repeatedDay);
    } else {
      _selectedReapeatedDays.remove(repeatedDay);
    }
    setState(() {});
  }

  void _addRemainder() async {
    final results = await showCalendarDatePicker2Dialog(
      context: context,
      value: [_reminderDate],
      config: CalendarDatePicker2WithActionButtonsConfig(),
      dialogSize: const Size(325, 400),
      borderRadius: BorderRadius.circular(15),
    );

    if (results != null && results.first != null && context.mounted) {
      DateTime date = results.first as DateTime;

      setState(
        () {
          _reminderDate = date;
        },
      );
    }
  }

  void _selectColor() {
    showModalBottomSheet(
        context: context,
        constraints: const BoxConstraints(
          maxWidth: double.infinity,
        ),
        builder: (ctx) {
          return SelectColorWidget(
            onColorTapped: (color) {
              setState(() {
                _selectedColor = color;
              });
              Navigator.of(context).pop();
            },
            selectedColor: _selectedColor,
          );
        });
  }

  void _deleteItem(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => CustomAlertDialog(
        onDelete: () {
          if (widget.item is AppTask) {
            BlocProvider.of<TasksBloc>(context).add(
              RemoveTaskEvent(
                taskId: (widget.item as AppTask).id,
              ),
            );

            BlocProvider.of<TasksBloc>(context).add(
              FetchTasksEvent(
                date: _date,
              ),
            );
          } else if (widget.item is Habit) {
            BlocProvider.of<HabitBloc>(context).add(
              RemoveHabitEvent(
                habitId: (widget.item as Habit).id,
              ),
            );

            BlocProvider.of<HabitBloc>(context).add(
              FetchHabitsEvent(),
            );
          }

          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        text: 'Do u want to delete this to-do?',
      ),
    );
  }
}
