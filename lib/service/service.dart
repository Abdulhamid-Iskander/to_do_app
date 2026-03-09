import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataService {
  final firestore = FirebaseFirestore.instance;

  Future<void> add(String title) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await firestore.collection('tasks').add({
        'title': title,
        'status': false,
        'userId': user.uid,
        'time': FieldValue.serverTimestamp(),
      });
    }
  }

  Stream<QuerySnapshot> get() {
    final user = FirebaseAuth.instance.currentUser;
    return firestore
        .collection('tasks')
        .where('userId', isEqualTo: user?.uid ?? '')
        .snapshots();
  }

  Future<void> delete(String id) async {
    await firestore.collection('tasks').doc(id).delete();
  }
}
