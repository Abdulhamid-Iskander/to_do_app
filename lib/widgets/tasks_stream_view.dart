import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../task_cubit/task_cubit.dart';
import '../task_cubit/task_state.dart';
import 'task_item_card.dart';

class TasksStreamView extends StatelessWidget {
  const TasksStreamView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        if (state is TasksLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFE91E63)),
          );
        }

        if (state is TasksError) {
          return Center(
            child: Text(
              "Error: ${state.message}",
              style: const TextStyle(color: Colors.redAccent),
            ),
          );
        }

        if (state is TasksLoaded) {
          final tasks = state.tasks;
          
          if (tasks.isEmpty) {
            return const Center(
              child: Text(
                "No tasks found. Start adding now!",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskItemCard(
                task: tasks[index],
                index: index,
              );
            },
          );
        }

        return const Center(
          child: Text("Waiting for tasks..."),
        );
      },
    );
  }
}