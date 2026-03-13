import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/cubit/auth/auth_cubit.dart';
import 'package:to_do_app/cubit/auth/auth_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void edit(BuildContext context, String title) {
    final input = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $title'),
          content: TextField(
            controller: input,
            decoration: InputDecoration(
              hintText: 'Enter new $title',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE91E63),
              ),
              onPressed: () {
                if (input.text.isNotEmpty) {
                  if (title == 'Name') {
                    context.read<AuthCubit>().updateName(input.text);
                  } else if (title == 'Email') {
                    context.read<AuthCubit>().updateEmail(input.text);
                  }
                  Navigator.pop(context);
                }
              },
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void lang(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                onTap: () {
                  context.read<AuthCubit>().updateLanguage('English');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Arabic'),
                onTap: () {
                  context.read<AuthCubit>().updateLanguage('Arabic');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/images/illustration.png',
                    height: 250,
                  ),
                  const SizedBox(height: 30),
                  item(
                    title: state.name, 
                    tap: () => edit(context, 'Name'),
                  ),
                  item(
                    title: state.email, 
                    tap: () => edit(context, 'Email'),
                  ),
                  item(
                    title: 'Change Password',
                    tap: () {
                      Navigator.pushNamed(context, '/change-password');
                    },
                  ),
                  item(
                    title: 'Language: ${state.language}', 
                    tap: () => lang(context),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    title: const Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE91E63),
                      ),
                    ),
                    onTap: () {
                      context.read<AuthCubit>().logout();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget item({required String title, required VoidCallback tap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 18,
        color: Colors.black87,
      ),
      onTap: tap,
    );
  }
}