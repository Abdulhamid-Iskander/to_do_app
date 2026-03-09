import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'task_item_card.dart';

/// Displays the list of task items.
class TaskListView extends StatelessWidget {
  final List<QueryDocumentSnapshot> documents;

  const TaskListView({super.key, required this.documents});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final data = documents[index].data() as Map<String, dynamic>;

        return TaskItemCard(
          index: index,
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          date: data['date'] ?? '',
        );
      },
    );
  }
}