part of 'habit_bloc.dart';

abstract class HabitEvent extends Equatable {
  const HabitEvent();

  @override
  List<Object> get props => [];
}

class RemoveHabitEvent extends HabitEvent {
  final String habitId;

  const RemoveHabitEvent({required this.habitId});

  @override
  List<Object> get props => [habitId];
}

class FetchHabitsEvent extends HabitEvent {}

class EditOrAddHabitEvent extends HabitEvent {
  final Habit habit;

  const EditOrAddHabitEvent({required this.habit});

  @override
  List<Object> get props => [habit];
}
