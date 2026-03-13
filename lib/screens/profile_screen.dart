import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/cubit/auth/auth_cubit.dart';
import 'package:to_do_app/cubit/auth/auth_state.dart';
import 'package:to_do_app/words/app_words.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void edit(BuildContext context, String title, String lang) {
    final input = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppWords.tr('Edit $title', lang)),
          content: TextField(
            controller: input,
            decoration: InputDecoration(
              hintText: AppWords.tr('Enter new $title', lang),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppWords.tr('Cancel', lang), style: const TextStyle(color: Colors.grey)),
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
              child: Text(AppWords.tr('Save', lang), style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void langDialog(BuildContext context, String lang) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppWords.tr('Language', lang)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(AppWords.tr('English', lang)),
                onTap: () {
                  context.read<AuthCubit>().updateLanguage('English');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(AppWords.tr('Arabic', lang)),
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
        final lang = state.language;
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
                    title: AppWords.tr(state.name, lang),
                    tap: () => edit(context, 'Name', lang),
                    lang: lang,
                  ),
                  item(
                    title: AppWords.tr(state.email, lang),
                    tap: () => edit(context, 'Email', lang),
                    lang: lang,
                  ),
                  item(
                    title: AppWords.tr('Change Password', lang),
                    tap: () {
                      Navigator.pushNamed(context, '/change-password');
                    },
                    lang: lang,
                  ),
                  item(
                    title: "${AppWords.tr('Language', lang)}: ${AppWords.tr(state.language, lang)}",
                    tap: () => langDialog(context, lang),
                    lang: lang,
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    title: Text(
                      AppWords.tr('Log Out', lang),
                      style: const TextStyle(
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

  Widget item({required String title, required VoidCallback tap, required String lang}) {
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
      trailing: Icon(
        lang == 'Arabic' ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
        size: 18,
        color: Colors.black87,
      ),
      onTap: tap,
    );
  }
}