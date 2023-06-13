import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/habits/presentation/habit_bloc/habit_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/no_data_widget.dart';
import '../widgets/habits_widget.dart';

class HabitPage extends StatelessWidget {
  const HabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitBloc, HabitState>(
      builder: (context, state) {
        switch (state) {
          case LoadedHabitState():
            if (state.habits.isEmpty) {
              return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Platform.isIOS || Platform.isAndroid ? 106 : 76,
                    ),
                    const Center(
                      child: NoDataWidget(
                        animationUrl: "assets/lottie/nothing.json",
                        text: 'Add some habits',
                      ),
                    ),
                  ],
                ),
              );
            }
            return HabitsWidget(
              habits: state.habits,
            );

          case LoadingHabitState():
            return const LoadingWidget();
          case ErrorHabitsState():
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
}
