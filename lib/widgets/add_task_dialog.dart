import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Displays dialog used to create a new task.
class AddTaskDialog {
  static void show(BuildContext context, String? userId) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Task"),
          content: AddTaskForm(
            titleController: titleController,
            descriptionController: descriptionController,
          ),
          actions: [
            AddTaskButton(
              titleController: titleController,
              descriptionController: descriptionController,
              userId: userId,
            ),
          ],
        );
      },
    );
  }
}

/// Form fields for adding a new task.
class AddTaskForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const AddTaskForm({
    super.key,
    required this.titleController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: titleController,
          decoration: const InputDecoration(hintText: "Title"),
        ),
        TextField(
          controller: descriptionController,
          decoration: const InputDecoration(hintText: "Description"),
        ),
      ],
    );
  }
}

/// Handles Firestore write operation for adding a task.
class AddTaskButton extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final String? userId;

  const AddTaskButton({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await FirebaseFirestore.instance.collection('tasks').add({
          'title': titleController.text,
          'description': descriptionController.text,
          'userId': userId,
          'date': DateTime.now().toString(),
        });

        Navigator.pop(context);
      },
      child: const Text("Add"),
    );
  }
}