import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/widgets/tasks/custom_add_task_field.dart';
import '../../cubit/task_cubit/task_cubit.dart';
import '../../models/task_model.dart';
import 'package:to_do_app/cubit/auth/auth_cubit.dart';
import 'package:to_do_app/core/app_words.dart';

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
    final primaryColor = Theme.of(context).primaryColor;
    final lang = context.watch<AuthCubit>().state.language;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 25),
              CustomAddTaskField(controller: title, hintText: AppWords.tr("Title", lang)),
              const SizedBox(height: 15),
              CustomAddTaskField(controller: desc, hintText: AppWords.tr("Description", lang), maxLines: 5),
              const SizedBox(height: 15),
              CustomAddTaskField(controller: deadline, hintText: AppWords.tr("Deadline", lang), suffixIcon: Icons.calendar_today),
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
                  child: Text(AppWords.tr("Save", lang), style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}