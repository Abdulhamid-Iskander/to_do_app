import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  final String? description; 
  final String? deadline; 
  final String? imageUrl; 
  final bool status;
  final String userId;
  final String? createdAt; 

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    this.deadline,
    this.imageUrl,
    required this.status,
    required this.userId,
    this.createdAt,
  });

  factory TaskModel.fromFirestore(Map<String, dynamic> json, String id) {
    String? formattedDate;
    if (json['time'] != null) {
      DateTime date = (json['time'] as Timestamp).toDate();
      
      final y = date.year;
      final m = date.month.toString().padLeft(2, '0');
      final d = date.day.toString().padLeft(2, '0');
      
      int hour = date.hour;
      String period = hour >= 12 ? 'PM' : 'AM';
      int h12 = hour % 12;
      if (h12 == 0) h12 = 12;
      final h = h12.toString().padLeft(2, '0');
      final min = date.minute.toString().padLeft(2, '0');
      
      formattedDate = "$y-$m-$d $h:$min $period";
    }

    return TaskModel(
      id: id,
      title: json['title'] ?? '',
      description: json['description'],
      deadline: json['deadline'],
      imageUrl: json['imageUrl'],
      status: json['status'] ?? false,
      userId: json['userId'] ?? '',
      createdAt: formattedDate,
    );
  }
}