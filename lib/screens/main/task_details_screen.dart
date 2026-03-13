import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/app_words.dart';
import 'package:to_do_app/widgets/tasks/delete_bottom_sheet.dart';
import 'package:to_do_app/widgets/tasks/edit_task_view.dart';
import '../../models/task_model.dart';

import 'package:to_do_app/cubit/auth/auth_cubit.dart';

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
            onPressed: () => EditTaskDialog.show(context, task),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, color: iconColor),
            onPressed: () => DeleteBottomSheet.show(context, task.id),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (task.imageUrl != null && task.imageUrl!.isNotEmpty)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: task.imageUrl!.startsWith('http')
                        ? Image.network(
                            task.imageUrl!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(task.imageUrl!),
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              const SizedBox(height: 20),
              Text(task.title, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 25),
              Text(
                task.description ?? AppWords.tr('No description provided.', lang),
                style: const TextStyle(fontSize: 18, color: Colors.grey, height: 1.6),
              ),
              const Spacer(),
              Center(
                child: Column(
                  children: [
                    if (task.createdAt != null)
                      Text(
                        "${AppWords.tr('Created at ', lang)}${formatArabicTime(task.createdAt, lang)}",
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      "${AppWords.tr('Deadline', lang)}: ${task.deadline != null && task.deadline!.isNotEmpty ? formatArabicTime(task.deadline, lang) : AppWords.tr('N/A', lang)}",
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
  }
}