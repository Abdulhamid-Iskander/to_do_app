import 'package:flutter/material.dart';
import 'add_task_view.dart';

class AddTaskDialog {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true, 
      builder: (context) {
        return const AddTaskView();
      },
    );
  }
}