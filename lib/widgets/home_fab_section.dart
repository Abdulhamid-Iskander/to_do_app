import 'package:flutter/material.dart';
import 'package:to_do_app/widgets/add_task_fab_button.dart';
import 'package:to_do_app/widgets/theme_fab_button.dart';

class HomeFabSection extends StatelessWidget {
  const HomeFabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        ThemeFabButton(),
        SizedBox(height: 12),
        AddTaskFabButton(),
      ],
    );
  }
}