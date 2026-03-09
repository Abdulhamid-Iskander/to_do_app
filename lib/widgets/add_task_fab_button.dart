import 'package:flutter/material.dart';
import 'add_task_dialog.dart';
class AddTaskFabButton extends StatelessWidget {
  const AddTaskFabButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'add_task',
      onPressed: () => AddTaskDialog.show(context),
      backgroundColor: const Color(0xFFE91E63), 
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: const Icon(Icons.add_rounded, size: 30, color: Colors.white),
    );
  }
}