import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/service/service.dart';
import 'package:to_do_app/task_cubit/task_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final DataService _service = DataService();

  TasksCubit() : super(TasksInitial());

  void fetchTasks() {
    emit(TasksLoading());

    _service.getTasks().listen(
      (tasks) => emit(TasksLoaded(tasks)),
      onError: (e) => emit(TasksError(e.toString())),
    );
  }

  void addTask(String title , {String? description, String ?deadline, String ?imageUrl}) {
    _service.add(title ,
    description : description ,
    deadline : deadline ,
    imageUrl : imageUrl
    );
  }
void editTask(String id, String title, {String? description, String? deadline, String? imageUrl}) {
  _service.update(id, title, description: description, deadline: deadline, imageUrl: imageUrl);
}
  void deleteTask(String id) {
    _service.delete(id);
  }

  void toggleTask(String id, bool status) {
    _service.toggleStatus(id, status);
  }
}