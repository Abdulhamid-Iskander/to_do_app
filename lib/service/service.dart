import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/models/task_model.dart';

class DataService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> add(String title, {String? description, String? deadline, String? imageUrl}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    
    await _firestore.collection('tasks').add({
      'title': title,
      'description': description,
      'deadline': deadline,
      'imageUrl': imageUrl,
      'status': false,
      'userId': user.uid,
      'time': FieldValue.serverTimestamp(),
    });
  }

  Future<void> update(String id, String title, {String? description, String? deadline, String? imageUrl}) async {
    await _firestore.collection('tasks').doc(id).update({
      'title': title,
      'description': description,
      'deadline': deadline,
      'imageUrl': imageUrl,
    });
  }

  Stream<List<TaskModel>> getTasks() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Stream.value([]);
    
    return _firestore
        .collection('tasks')
        .where('userId', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) {
      final tasks = snapshot.docs.map((doc) {
        return TaskModel.fromFirestore(doc.data(), doc.id);
      }).toList();
      
      return tasks.reversed.toList();
    });
  }

  Future<void> toggleStatus(String id, bool currentStatus) async {
    await _firestore.collection('tasks').doc(id).update({'status': !currentStatus});
  }

  Future<void> delete(String id) async {
    await _firestore.collection('tasks').doc(id).delete();
  }
}