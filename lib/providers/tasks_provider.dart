import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:to_do_app/models/tasks.dart';

part 'tasks_provider.g.dart';

@riverpod
class TaskNotifier extends _$TaskNotifier {
  @override
  List<Task> build() {
    return [];
  }

  void addTask(Task task) {
    if (!state.contains(task)) {
      if (state.any((t) => t.title == task.title)) {
        return;
      }
      state = [...state, task];
    }
  }

  void deleteTask(Task task) {
    state = state.where((element) => element.title != task.title).toList();
  }

  void isCompletedTask(Task task) {
    state = state.map((e) => e.title == task.title ? e.copyWith(completed: true) : e).toList();
  }

  void editTask(Task task, String title) {
    state = state.map((e) => e.title == title ? e.copyWith(title: task.title, description: task.description) : task).toList();
  }
}