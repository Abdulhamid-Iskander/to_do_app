import 'package:flutter/material.dart';

/// Represents a single task card in the list.
class TaskItemCard extends StatelessWidget {
  final int index;
  final String title;
  final String description;
  final String date;

  const TaskItemCard({
    super.key,
    required this.index,
    required this.title,
    required this.description,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
    index % 2 == 0 ? const Color(0xFFE91E63) : const Color(0xFFF48FB1);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TaskTitleRow(title: title),
          const SizedBox(height: 10),
          TaskDescriptionText(description: description),
          const SizedBox(height: 20),
          TaskDateText(date: date),
        ],
      ),
    );
  }
}

/// Displays task title and time icon.
class TaskTitleRow extends StatelessWidget {
  final String title;

  const TaskTitleRow({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Icon(
          Icons.access_time,
          color: Colors.white,
          size: 20,
        ),
      ],
    );
  }
}

/// Displays task description.
class TaskDescriptionText extends StatelessWidget {
  final String description;

  const TaskDescriptionText({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 14,
      ),
    );
  }
}

/// Displays task creation date.
class TaskDateText extends StatelessWidget {
  final String date;

  const TaskDateText({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Created at $date",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
    );
  }
}