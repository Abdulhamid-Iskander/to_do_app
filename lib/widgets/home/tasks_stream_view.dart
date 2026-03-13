import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/task_cubit/task_cubit.dart';
import '../../cubit/task_cubit/task_state.dart';
import '../tasks/task_item_card.dart';
import 'package:to_do_app/cubit/auth/auth_cubit.dart';
import 'package:to_do_app/core/app_words.dart';

class TasksStreamView extends StatelessWidget {
  const TasksStreamView({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final lang = context.watch<AuthCubit>().state.language;

    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        if (state is TasksLoading) {
          return Center(
            child: CircularProgressIndicator(color: primaryColor),
          );
        }

        if (state is TasksError) {
          return Center(
            child: Text(
              "${AppWords.tr('Error', lang)}: ${state.message}",
              style: const TextStyle(color: Colors.redAccent),
            ),
          );
        }

        if (state is TasksLoaded) {
          final tasks = state.tasks;
          
          if (tasks.isEmpty) {
            return Center(
              child: Text(
                AppWords.tr("No tasks found. Start adding now!", lang),
                style: const TextStyle(color: Colors.grey, fontSize: 16),
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

        return Center(
          child: Text(AppWords.tr("Waiting for tasks...", lang)),
        );
      },
    );
  }
}