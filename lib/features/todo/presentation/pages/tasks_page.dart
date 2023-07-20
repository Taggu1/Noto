import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/widgets/loading_widget.dart';
import 'package:note_app/features/note/presentation/widgets/toggle_mode_actions.dart';
import 'package:note_app/features/todo/presentation/cubit/task_page_date_cubit.dart';
import 'package:note_app/features/todo/presentation/widgets/my_day_widget.dart';
import 'package:note_app/features/todo/presentation/widgets/tasks_widget.dart';

import '../../../../core/widgets/no_data_widget.dart';
import '../tasks/tasks_bloc.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({
    super.key,
  });

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  bool _toggleMode = false;

  final Map<String, int?> _toggleIndexesMap = {};
  DateTime _date = DateTime.now();

  @override
  void initState() {
    _date = BlocProvider.of<TaskPageDateCubit>(context).state.dateTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        switch (state) {
          case LoadedTasksState():
            if (state.tasks.isEmpty) {
              return Expanded(
                child: ListView(
                  children: [
                    if (Platform.isIOS || Platform.isAndroid)
                      const SizedBox(
                        height: 30,
                      ),
                    if (!_toggleMode)
                      Align(
                        alignment: Alignment.topLeft,
                        child: MyDayWidget(
                          onDateTapped: _onDateTapped,
                          date: _date,
                        ),
                      ),
                    const SizedBox(
                      height: 76,
                    ),
                    const Center(
                      child: NoDataWidget(
                        animationUrl: "assets/lottie/nothing.json",
                        text: 'Add some tasks',
                      ),
                    ),
                  ],
                ),
              );
            }
            return Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (Platform.isIOS || Platform.isAndroid)
                    const SizedBox(
                      height: 30,
                    ),
                  if (!_toggleMode)
                    MyDayWidget(
                      onDateTapped: _onDateTapped,
                      date: _date,
                    ),
                  if (_toggleMode)
                    ToggleModeActions(
                      notesIds: _toggleIndexesMap.keys.toList(),
                      offToggleMode: _offToggleMode,
                      onDelete: _onDelete,
                    ),
                  TasksWidget(
                    tasks: state.tasks,
                    toggleHoldMode: _toggleHoldMode,
                    toggledTasksIndexes: _toggleIndexesMap.keys.toList(),
                    toggledMode: _toggleMode,
                    date: _date,
                  ),
                ],
              ),
            );
          case LoadingTasksState():
            return const LoadingWidget();
          case ErrorTasksState():
            return Center(
              child: Text(
                state.message,
              ),
            );
        }
        return Container();
      },
    );
  }

  void _onDateTapped() async {
    final results = await showCalendarDatePicker2Dialog(
      context: context,
      value: [
        _date,
      ],
      config: CalendarDatePicker2WithActionButtonsConfig(),
      dialogSize: const Size(325, 400),
      borderRadius: BorderRadius.circular(15),
    );
    if (results?.first != null) {
      setState(() {
        _date = results!.first!;
      });
      BlocProvider.of<TaskPageDateCubit>(context).updateDate(_date);
      BlocProvider.of<TasksBloc>(context).add(FetchTasksEvent(date: _date));
    }
  }

  void _toggleHoldMode(taksId, intId) {
    if (_toggleIndexesMap.keys.contains(taksId)) {
      _toggleIndexesMap.remove(taksId);
    } else {
      _toggleIndexesMap[taksId] = intId;
    }

    if (_toggleMode == false) {
      _toggleMode = true;
    } else if (_toggleIndexesMap.isEmpty) {
      _toggleMode = false;
    }
    setState(() {});
  }

  void _offToggleMode() {
    setState(() {
      _toggleMode = false;
    });
  }

  void _onDelete() {
    Navigator.of(context).pop();
    BlocProvider.of<TasksBloc>(context).add(
      RemoveTasksEvent(idsMap: _toggleIndexesMap),
    );

    Future.delayed(
      const Duration(
        milliseconds: 200,
      ),
      () {
        BlocProvider.of<TasksBloc>(context).add(FetchTasksEvent(date: _date));
        if (_toggleIndexesMap.isNotEmpty) {
          _toggleIndexesMap.clear();
        }
        _offToggleMode();
      },
    );
  }
}
