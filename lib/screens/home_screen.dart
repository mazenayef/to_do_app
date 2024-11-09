import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/models/tasks.dart';
import 'package:to_do_app/providers/tasks_provider.dart';
import 'package:to_do_app/screens/completed_tasks_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskNotifierProvider);
    final uncompletedTasks =
        tasks.where((element) => !element.completed).toList();
    const IconData completedTaskIcon =
        IconData(0xe645, fontFamily: 'MaterialIcons');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: const Icon(completedTaskIcon),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CompletedTasksScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: uncompletedTasks.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) {
                  final titleController = TextEditingController();
                  final descriptionController = TextEditingController();
                  return AlertDialog(
                    title: const Text('Edit Task'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController
                            ..text = uncompletedTasks[index].title,
                          decoration: const InputDecoration(
                            hintText: 'Title',
                          ),
                        ),
                        TextField(
                          controller: descriptionController
                            ..text = uncompletedTasks[index].description,
                          decoration: const InputDecoration(
                            hintText: 'Description',
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          final task = Task(
                            title: titleController.text,
                            description: descriptionController.text,
                          );
                          ref
                              .watch(taskNotifierProvider.notifier)
                              .editTask(task, uncompletedTasks[index].title);
                          Navigator.pop(context);
                        },
                        child: const Text('Edit'),
                      ),
                    ],
                  );
                },
              );
            },
            child: ListTile(
              title: Text(uncompletedTasks[index].title),
              subtitle: Text(uncompletedTasks[index].description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () {
                      ref
                          .read(taskNotifierProvider.notifier)
                          .isCompletedTask(uncompletedTasks[index]);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref
                          .read(taskNotifierProvider.notifier)
                          .deleteTask(uncompletedTasks[index]);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  final titleController = TextEditingController();
                  final descriptionController = TextEditingController();
                  return AlertDialog(
                    title: const Text('Add Task'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            hintText: 'Title',
                          ),
                        ),
                        TextField(
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            hintText: 'Description',
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          final task = Task(
                            title: titleController.text,
                            description: descriptionController.text,
                          );
                          ref.read(taskNotifierProvider.notifier).addTask(task);
                          Navigator.pop(context);
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
