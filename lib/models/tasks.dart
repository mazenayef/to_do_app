import 'package:to_do_app/classes/guidgen.dart';

class Task {
  Task({required this.title,required this.description, this.completed = false});
  Task copyWith({String? title, String? description, bool? completed, String? id}) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }
  final String id = GUIDGen.generate();
  final String title;
  final String description;
  bool completed;
}