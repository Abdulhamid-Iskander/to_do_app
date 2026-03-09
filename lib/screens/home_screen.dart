import 'package:flutter/material.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/tasks_stream_view.dart';
import '../widgets/home_fab_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF8F9FA), 
      appBar: HomeAppBar(),
      
      body: TasksStreamView(), 
      
      floatingActionButton: HomeFabSection(),
    );
  }
}