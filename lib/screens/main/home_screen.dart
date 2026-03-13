import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/cubit/task_cubit/task_cubit.dart';
import '../../widgets/home/home_app_bar.dart';
import '../../widgets/home/tasks_stream_view.dart';
import '../../widgets/home/home_fab_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TasksCubit>().fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeAppBar(),
      body: TasksStreamView(),
      floatingActionButton: HomeFabSection(),
    );
  }
}