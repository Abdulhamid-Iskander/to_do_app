import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/service/service.dart';
import 'package:to_do_app/task_cubit/task_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final DataService _service = DataService();
  StreamSubscription? _tasksSubscription;

  TasksCubit() : super(TasksInitial());

  void fetchTasks() {
    if (state is TasksLoading) return;
    
    emit(TasksLoading());
    _tasksSubscription?.cancel();
    
    _tasksSubscription = _service.getTasks().listen(
      (tasks) {
        if (!isClosed) emit(TasksLoaded(tasks));
      },
      onError: (e) {
        if (!isClosed) emit(TasksError(e.toString()));
      },
    );
  }

  Future<void> addTask(String title, {String? description, String? deadline, String? imageUrl}) async {
    try {
      await _service.add(title, description: description, deadline: deadline, imageUrl: imageUrl);
    } catch (e) {
      if (!isClosed) emit(TasksError(e.toString()));
    }
  }

  Future<void> editTask(String id, String title, {String? description, String? deadline, String? imageUrl}) async {
    try {
      await _service.update(id, title, description: description, deadline: deadline, imageUrl: imageUrl);
    } catch (e) {
      if (!isClosed) emit(TasksError(e.toString()));
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _service.delete(id);
    } catch (e) {
      if (!isClosed) emit(TasksError(e.toString()));
    }
  }

  Future<void> toggleTask(String id, bool status) async {
    try {
      await _service.toggleStatus(id, status);
    } catch (e) {
      if (!isClosed) emit(TasksError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _tasksSubscription?.cancel();
    return super.close();
  }
}