import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/app_words.dart';
import 'package:to_do_app/cubit/task_cubit/task_state.dart';
import 'package:to_do_app/widgets/tasks/delete_bottom_sheet.dart';
import 'package:to_do_app/widgets/tasks/edit_task_view.dart';
import '../../models/task_model.dart';
import 'package:to_do_app/cubit/auth/auth_cubit.dart';
import 'package:to_do_app/cubit/task_cubit/task_cubit.dart';

class TaskDetailsScreen extends StatelessWidget {
  final TaskModel task;
  const TaskDetailsScreen({super.key, required this.task});

  String formatArabicTime(String? time, String lang) {
    if (time == null) return '';
    return time.replaceAll('AM', AppWords.tr('AM', lang)).replaceAll('PM', AppWords.tr('PM', lang));
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<AuthCubit>().state.language;
    final iconColor = Theme.of(context).iconTheme.color;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        TaskModel currentTask = task;
        
        if (state is TasksLoaded) {
          try {
            currentTask = state.tasks.firstWhere((t) => t.id == task.id);
          } catch (e) {
            currentTask = task;
          }
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: iconColor),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.edit_outlined, color: iconColor),
                onPressed: () => EditTaskDialog.show(context, currentTask),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: iconColor),
                onPressed: () => DeleteBottomSheet.show(context, currentTask.id),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (currentTask.imageUrl != null && currentTask.imageUrl!.isNotEmpty)
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: currentTask.imageUrl!.startsWith('http')
                            ? Image.network(
                                currentTask.imageUrl!,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(currentTask.imageUrl!),
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Text(currentTask.title, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: textColor)),
                  const SizedBox(height: 25),
                  Text(
                    currentTask.description ?? AppWords.tr('No description provided.', lang),
                    style: const TextStyle(fontSize: 18, color: Colors.grey, height: 1.6),
                  ),
                  const Spacer(),
                  Center(
                    child: Column(
                      children: [
                        if (currentTask.createdAt != null)
                          Text(
                            "${AppWords.tr('Created at ', lang)}${formatArabicTime(currentTask.createdAt, lang)}",
                            style: const TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        const SizedBox(height: 8),
                        Text(
                          "${AppWords.tr('Deadline', lang)}: ${currentTask.deadline != null && currentTask.deadline!.isNotEmpty ? formatArabicTime(currentTask.deadline, lang) : AppWords.tr('N/A', lang)}",
                          style: const TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}