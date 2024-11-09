import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:to_do_app/models/tasks.dart';
import 'package:to_do_app/providers/tasks_provider.dart';

part 'completed_tasks_provider.g.dart';

@riverpod
class CompletedTasksNotifier extends _$CompletedTasksNotifier {
  @override
  List<Task> build() {
    final allTasks = ref.watch(taskNotifierProvider);
    final completedTasks = allTasks.where((task) => task.completed).toList();
    if (completedTasks.isEmpty) {
      return [];
    }
    else {
      return completedTasks;
    }
  }
}
