part of 'task_page_date_cubit.dart';

class TaskPageDateState extends Equatable {
  final DateTime dateTime;
  const TaskPageDateState({required this.dateTime});

  @override
  List<Object> get props => [dateTime];
}
