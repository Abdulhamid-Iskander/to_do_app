import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/cubit/auth/auth_cubit.dart';
import 'package:to_do_app/cubit/auth/auth_state.dart';
import 'package:to_do_app/core/app_words.dart';
import 'package:to_do_app/widgets/shared/custom_auth_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();
  final confirm = TextEditingController();

  void showErrorDialog(String message, String lang) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(AppWords.tr("Error", lang), style: const TextStyle(color: Colors.red)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppWords.tr("Cancel", lang), style: TextStyle(color: Theme.of(context).primaryColor)),
          ),
        ],
      ),
    );
  }

  void registerAction(String lang) {
    if (email.text.isEmpty || pass.text.isEmpty || name.text.isEmpty) {
      showErrorDialog(AppWords.tr("All fields are required", lang), lang);
      return;
    }
    if (pass.text != confirm.text) {
      showErrorDialog(AppWords.tr("The password does not match", lang), lang);
      return;
    }
    context.read<AuthCubit>().registerUser(name.text, email.text, pass.text);
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          final lang = state.language;
          if (state.authError != null) {
            showErrorDialog(AppWords.tr(state.authError!, lang), lang);
          } else if (state.isSuccess) {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          }
        },
        builder: (context, state) {
          final lang = state.language;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Text(
                    AppWords.tr("Sign Up", lang),
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  CustomAuthField(controller: name, label: AppWords.tr("Full Name", lang)),
                  const SizedBox(height: 15),
                  CustomAuthField(controller: email, label: AppWords.tr("Email", lang)),
                  const SizedBox(height: 15),
                  CustomAuthField(controller: pass, label: AppWords.tr("Password", lang), isPassword: true),
                  const SizedBox(height: 15),
                  CustomAuthField(controller: confirm, label: AppWords.tr("Confirm Password", lang), isPassword: true),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: state.isLoading ? null : () => registerAction(lang),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: state.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(AppWords.tr("Sign Up", lang), style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      AppWords.tr("Have an account? Sign in", lang),
                      style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}