import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/cubit/auth/auth_cubit.dart';
import 'package:to_do_app/cubit/auth/auth_state.dart';
import 'package:to_do_app/screens/auth/signup_screen.dart';
import 'package:to_do_app/core/app_words.dart';
import 'package:to_do_app/widgets/shared/custom_auth_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final pass = TextEditingController();

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

  void loginAction(String lang) {
    if (email.text.isEmpty || pass.text.isEmpty) {
      showErrorDialog(AppWords.tr("Please fill all fields", lang), lang);
      return;
    }
    context.read<AuthCubit>().loginUser(email.text, pass.text);
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
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        builder: (context, state) {
          final lang = state.language;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppWords.tr("Sign In", lang),
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                CustomAuthField(controller: email, label: AppWords.tr("Email", lang)),
                const SizedBox(height: 15),
                CustomAuthField(controller: pass, label: AppWords.tr("Password", lang), isPassword: true),
                Align(
                  alignment: lang == 'Arabic' ? Alignment.centerLeft : Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(AppWords.tr("Forgot Password?", lang), style: TextStyle(color: primaryColor)),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: state.isLoading ? null : () => loginAction(lang),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: state.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(AppWords.tr("Sign In", lang), style: const TextStyle(color: Colors.white)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpScreen()),
                    );
                  },
                  child: Text(
                    AppWords.tr("Don't have an account? Sign up", lang),
                    style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}