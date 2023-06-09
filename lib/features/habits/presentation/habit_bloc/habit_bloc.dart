import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app/features/habits/domain/repository/habit_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/models/habit.dart';

part 'habit_event.dart';
part 'habit_state.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final HabitRepository habitRepository;
  HabitBloc(this.habitRepository) : super(HabitInitial()) {
    on<HabitEvent>((event, emit) async {
      if (event is FetchHabitsEvent) {
        emit(LoadingHabitState());
        final notesOrFailure = await habitRepository.fetchHabits();

        emit(_habitsOrFailureTohabitState(notesOrFailure));
      } else if (event is EditOrAddHabitEvent) {
        final unitOrFailure = await habitRepository.addOrEditHabit(
          habit: event.habit,
        );

        emit(
          _unitOrFailureTohabitState(unitOrFailure),
        );
      } else if (event is RemoveHabitEvent) {
        await habitRepository.removeHabit(habitId: event.habitId);
      }
    });
  }

  HabitState _habitsOrFailureTohabitState(
      Either<Failure, List<Habit>> notesOrFailure) {
    return notesOrFailure.fold(
      (failure) => const ErrorHabitsState(
          message: "Something happened while loading the notes"),
      (habits) => LoadedHabitState(habits: habits),
    );
  }

  HabitState _unitOrFailureTohabitState(
    Either<Failure, Unit> unitOrFailure,
  ) {
    return unitOrFailure.fold(
      (faliure) => const ErrorHabitsState(
          message: "Something worng happend while loading the notes"),
      (unit) {
        return state;
      },
    );
  }
}
