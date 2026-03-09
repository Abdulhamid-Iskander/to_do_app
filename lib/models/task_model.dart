class TaskModel {
  final String id;
  final String title;
  final String? description; 
  final String? deadline; 
  final String? imageUrl; 
  final bool status;
  final String userId;

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    this.deadline,
    this.imageUrl,
    required this.status,
    required this.userId,
  });

  factory TaskModel.fromFirestore(Map<String, dynamic> json, String id) {
    return TaskModel(
      id: id,
      title: json['title'] ?? '',
      description: json['description'],
      deadline: json['deadline'],
      imageUrl: json['imageUrl'],
      status: json['status'] ?? false,
      userId: json['userId'] ?? '',
    );
  }
}