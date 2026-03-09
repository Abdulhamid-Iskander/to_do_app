import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'task_list_view.dart';

/// Handles Firestore stream and provides real-time task updates.
class TasksStreamView extends StatelessWidget {
  final String? userId;

  const TasksStreamView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('tasks')
          .where('userId', isEqualTo: userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data?.docs ?? [];

        return TaskListView(documents: docs);
      },
    );
  }
}