import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/cubit/auth/auth_cubit.dart';
import 'package:to_do_app/screens/signup_screen.dart';
import 'package:to_do_app/words/app_words.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final pass = TextEditingController();
  bool isLoading = false;

  void login() async {
    final lang = context.read<AuthCubit>().state.language;

    if (email.text.isEmpty || pass.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppWords.tr("Please fill all fields", lang))),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: pass.text.trim(),
      );

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      String message = AppWords.tr("An error occurred", lang);
      if (e.code == 'user-not-found') {
        message = AppWords.tr("No user found for that email.", lang);
      } else if (e.code == 'wrong-password') {
        message = AppWords.tr("Wrong password provided.", lang);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<AuthCubit>().state.language;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppWords.tr("Sign In", lang), style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            TextField(
              controller: email,
              decoration: InputDecoration(
                labelText: AppWords.tr("Email", lang),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: pass,
              obscureText: true,
              decoration: InputDecoration(
                labelText: AppWords.tr("Password", lang),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            Align(
alignment: lang == 'Arabic' ? Alignment.centerLeft : Alignment.centerRight,              child: TextButton(
                onPressed: () {},
                child: Text(AppWords.tr("Forgot Password?", lang), style: const TextStyle(color: Colors.pink)),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: isLoading
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
              child: Text(AppWords.tr("Don't have an account? Sign up", lang), style: const TextStyle(color: Colors.black54)),
            ),
          ],
        ),
      ),
    );
  }
}