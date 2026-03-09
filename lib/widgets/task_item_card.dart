import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../task_cubit/task_cubit.dart';
import '../models/task_model.dart';

class TaskItemCard extends StatelessWidget {
  final TaskModel task;
  final int index;

  const TaskItemCard({super.key, required this.task, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
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
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "#${index + 1}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 15,
                  width: 1,
                  color: Colors.grey[300],
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: task.status
                        ? Colors.grey[200]
                        : const Color(0xFFFFEBF2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    task.status ? "Completed" : "Pending",
                    style: TextStyle(
                      fontSize: 12,
                      color: task.status
                          ? Colors.grey[600]
                          : const Color(0xFFE91E63),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                    size: 20,
                  ),
                  onPressed: () =>
                      context.read<TasksCubit>().deleteTask(task.id),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          color: task.status ? Colors.grey : Colors.black87,
                          decoration: task.status
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      if (task.description != null &&
                          task.description!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            task.description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      if (task.deadline != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 16,
                                color: task.status
                                    ? Colors.grey
                                    : const Color(0xFFE91E63),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Deadline: ${task.deadline!}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: task.status
                                      ? Colors.grey
                                      : const Color(0xFFE91E63),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                GestureDetector(
                  onTap: () => context.read<TasksCubit>().toggleTask(
                    task.id,
                    task.status,
                  ),
                  child: Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      value: task.status,
                      activeColor: const Color(0xFFE91E63),
                      checkColor: Colors.white,
                      shape: const CircleBorder(),
                      side: BorderSide(
                        color: task.status
                            ? Colors.transparent
                            : const Color(0xFFE91E63),
                        width: 2,
                      ),
                      onChanged: (_) => context.read<TasksCubit>().toggleTask(
                        task.id,
                        task.status,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
