import 'dart:io';
import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../screens/task_details_screen.dart';

class TaskItemCard extends StatelessWidget {
  final TaskModel task;
  final int index;

  const TaskItemCard({super.key, required this.task, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TaskDetailsScreen(task: task)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE91E63).withOpacity(0.15), 
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: const BoxDecoration(
                color: Color(0xFFE91E63), 
                borderRadius: BorderRadius.only(
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
                      task.status ? "Completed" : "Pending",
                      style: TextStyle(
                        fontSize: 12,
                        color: task.status ? Colors.green : const Color(0xFFE91E63), 
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
                            color: task.status ? Colors.grey : Colors.black87,
                          ),
                        ),
                        if (task.deadline != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Created at ${task.deadline}",
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFFE91E63)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}