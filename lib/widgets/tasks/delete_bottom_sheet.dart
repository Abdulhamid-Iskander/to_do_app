import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/task_cubit/task_cubit.dart';
import 'package:to_do_app/cubit/auth/auth_cubit.dart';
import 'package:to_do_app/core/app_words.dart';

class DeleteBottomSheet {
  static void show(BuildContext context, String taskId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final primaryColor = Theme.of(context).primaryColor;
        final lang = context.watch<AuthCubit>().state.language;
        final bgColor = Theme.of(context).scaffoldBackgroundColor;

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    context.read<TasksCubit>().deleteTask(taskId);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppWords.tr("Delete TODO", lang), 
                    style: TextStyle(color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold)
                  ),
                ),
              ),
              const Divider(),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    AppWords.tr("Cancel", lang), 
                    style: const TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold)
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}