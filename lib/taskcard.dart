// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class Task {
  int id;
  String taskText;
  bool isCompleted;
  Task({required this.id, required this.taskText, this.isCompleted = false});

// -------------------- test cases ------------------

  static List<Task> Tasks() {
    return [
      Task(id: -1, taskText: 'get started with flutter', isCompleted: true),
      Task(id: 0, taskText: 'learn the basics of flutter', isCompleted: true),
      Task(id: 1, taskText: 'Complete task manager', isCompleted: true),
      Task(id: 2, taskText: 'make a note taking app with flutter'),
      Task(id: 3, taskText: 'make a gallery app in flutter'),
      Task(id: 4, taskText: 'make a messenger app with flutter'),
// ---------------------------------------------------
    ];
  }
}

class TaskCard extends StatelessWidget {
  final Task mytask;
  final onTaskToggle;
  final onDelete;

  const TaskCard(
      {super.key,
      required this.mytask,
      required this.onDelete,
      required this.onTaskToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: ListTile(
        onTap: () {
          onTaskToggle(mytask);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        tileColor: Theme.of(context).colorScheme.primaryContainer,
        leading: Icon(
          mytask.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          mytask.taskText,
          style: TextStyle(
            decoration: mytask.isCompleted ? TextDecoration.lineThrough : null,
            decorationThickness: 1.5,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 7),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            icon: const Icon(Icons.delete),
            iconSize: 18,
            color: Theme.of(context).colorScheme.onTertiary,
            onPressed: (() => {onDelete(mytask.id)}),
          ),
        ),
      ),
    );
  }
}
