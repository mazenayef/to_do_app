import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/providers/completed_tasks_provider.dart';


class CompletedTasksScreen extends ConsumerStatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  ConsumerState createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends ConsumerState<CompletedTasksScreen> {
  @override
  Widget build(BuildContext context) {
    final completedTasks = ref.watch(completedTasksNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks'),
      ),
      body: ListView.builder(
        itemCount: completedTasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(completedTasks[index].title),
            subtitle: Text(completedTasks[index].description),
          );
        },
      ),
    );
  }
}