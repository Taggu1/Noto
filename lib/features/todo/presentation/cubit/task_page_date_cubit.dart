import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'task_page_date_state.dart';

class TaskPageDateCubit extends Cubit<TaskPageDateState> {
  TaskPageDateCubit() : super(TaskPageDateState(dateTime: DateTime.now()));

  void updateDate(DateTime dateTime) {
    emit(
      TaskPageDateState(
        dateTime: dateTime,
      ),
    );
  }
}
