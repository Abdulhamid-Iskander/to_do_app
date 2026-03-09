import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final oldPass = TextEditingController(); 
  final newPass = TextEditingController();
  final confirm = TextEditingController();

  void update() async {
    if (newPass.text != confirm.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("The passwords do not match")),
      );
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: oldPass.text,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPass.text.trim());

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password changed successfully!")),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Password")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: oldPass,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Old Password", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: newPass,
                obscureText: true,
                decoration: const InputDecoration(labelText: "New Password", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: confirm,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Confirm New Password", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 30),
              ElevatedButton(onPressed: update, child: const Text("Update Password")),
            ],
          ),
        ),
      ),
    );
  }
}