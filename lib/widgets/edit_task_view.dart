import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/widgets/custom_add_task_field.dart';
import '../cubit/task_cubit/task_cubit.dart';
import '../models/task_model.dart';

class EditTaskDialog {
  static void show(BuildContext context, TaskModel task) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => EditTaskView(task: task),
    );
  }
}

class EditTaskView extends StatefulWidget {
  final TaskModel task;
  const EditTaskView({super.key, required this.task});

  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  late TextEditingController title, desc, deadline, image;

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.task.title);
    desc = TextEditingController(text: widget.task.description);
    deadline = TextEditingController(text: widget.task.deadline);
    image = TextEditingController(text: widget.task.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF06292),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAddTaskField(controller: title, hintText: "Title"),
          const SizedBox(height: 15),
          CustomAddTaskField(controller: desc, hintText: "Description", maxLines: 10),
          const SizedBox(height: 15),
          CustomAddTaskField(controller: deadline, hintText: "Deadline", suffixIcon: Icons.calendar_today),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
              onPressed: () {
                context.read<TasksCubit>().editTask(widget.task.id, title.text, description: desc.text, deadline: deadline.text);
                Navigator.pop(context);
              },
              child: const Text("EDIT TODO", style: TextStyle(color: Color(0xFFE91E63), fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}