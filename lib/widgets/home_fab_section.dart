import 'package:flutter/material.dart';

import 'add_task_dialog.dart';

/// Contains floating action buttons used in HomeScreen.
class HomeFabSection extends StatelessWidget {
  final String? userId;

  const HomeFabSection({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const ThemeFabButton(),
        const SizedBox(height: 10),
        AddTaskFabButton(userId: userId),
      ],
    );
  }
}

/// Floating button used for theme change.
class ThemeFabButton extends StatelessWidget {
  const ThemeFabButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'theme',
      onPressed: () {},
      backgroundColor: const Color(0xFFE91E63),
      child: const Icon(Icons.palette_outlined),
    );
  }
}

/// Floating button used to open add task dialog.
class AddTaskFabButton extends StatelessWidget {
  final String? userId;

  const AddTaskFabButton({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'add',
      onPressed: () => AddTaskDialog.show(context, userId),
      backgroundColor: const Color(0xFFE91E63),
      child: const Icon(Icons.add),
    );
  }
}