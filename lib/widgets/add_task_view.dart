import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_app/task_cubit/task_cubit.dart';
import 'package:to_do_app/widgets/custom_add_task_field.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final title = TextEditingController();
  final desc = TextEditingController();
  final deadline = TextEditingController();
  final image = TextEditingController();

  Future<void> pick() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        image.text = file.path;
      });
    }
  }

  Future<void> select(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        deadline.text = picked.toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.pink[300],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(height: 25),
                CustomAddTaskField(
                  controller: title,
                  hintText: "Title",
                ),
                const SizedBox(height: 15),
                CustomAddTaskField(
                  controller: desc,
                  hintText: "Description",
                  maxLines: 8,
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () => select(context),
                  child: AbsorbPointer(
                    child: CustomAddTaskField(
                      controller: deadline,
                      hintText: "Deadline",
                      suffixIcon: Icons.calendar_today_outlined,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: pick,
                  child: AbsorbPointer(
                    child: CustomAddTaskField(
                      controller: image,
                      hintText: "Image",
                      suffixIcon: Icons.image_outlined,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      if (title.text.isNotEmpty) {
                        context.read<TasksCubit>().addTask(
                              title.text,
                              description: desc.text,
                              deadline: deadline.text,
                              imageUrl: image.text,
                            );
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Color(0xFFE91E63),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}