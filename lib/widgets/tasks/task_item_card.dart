import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/app_words.dart';
import '../../models/task_model.dart';
import '../../screens/main/task_details_screen.dart';
import 'package:to_do_app/cubit/auth/auth_cubit.dart';

class TaskItemCard extends StatelessWidget {
  final TaskModel task;
  final int index;

  const TaskItemCard({super.key, required this.task, required this.index});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<AuthCubit>().state.language;
    final primaryColor = Theme.of(context).primaryColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TaskDetailsScreen(task: task)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.15), 
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: primaryColor, 
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "#${index + 1}",
                    style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Container(height: 15, width: 1, color: Colors.white54, margin: const EdgeInsets.symmetric(horizontal: 10)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      AppWords.tr(task.status ? "Completed" : "Pending", lang),
                      style: TextStyle(
                        fontSize: 12,
                        color: task.status ? Colors.green : primaryColor, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (task.imageUrl != null && task.imageUrl!.isNotEmpty)
              Image.file(
                File(task.imageUrl!),
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: task.status ? TextDecoration.lineThrough : null,
                            color: task.status 
                                ? Colors.grey 
                                : (isDark ? Colors.white : Colors.black87),
                          ),
                        ),
                        if (task.deadline != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "${AppWords.tr('Created at ', lang)}${task.deadline}",
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Icon(
                    lang == 'Arabic' ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                    size: 16, 
                    color: primaryColor
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}