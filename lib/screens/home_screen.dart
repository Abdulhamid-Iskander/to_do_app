import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/home_app_bar.dart';
import '/widgets/tasks_stream_view.dart';
import '/widgets/home_fab_section.dart';

/// HomeScreen is the main screen displayed after user authentication.
/// It shows the list of tasks related to the current user.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HomeAppBar(),
      body: TasksStreamView(userId: user?.uid),
      floatingActionButton: HomeFabSection(userId: user?.uid),
    );
  }
}