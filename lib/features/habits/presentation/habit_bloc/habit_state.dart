part of 'habit_bloc.dart';

abstract class HabitState extends Equatable {
  const HabitState();

  @override
  List<Object> get props => [];
}

class HabitInitial extends HabitState {}

class LoadedHabitState extends HabitState {
  final List<Habit> habits;

  const LoadedHabitState({required this.habits});

  @override
  List<Object> get props => [habits];
}

class LoadingHabitState extends HabitState {}

class ErrorHabitsState extends HabitState {
  final String message;

  const ErrorHabitsState({required this.message});

  @override
  List<Object> get props => [message];
}
