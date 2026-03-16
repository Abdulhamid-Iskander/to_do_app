import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/cubit/auth/auth_cubit.dart';
import 'package:to_do_app/cubit/auth/auth_state.dart';
import 'package:to_do_app/core/app_words.dart';
import 'package:to_do_app/widgets/shared/custom_auth_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();

  void showCustomDialog(String title, String message, String lang, Color titleColor, bool isSuccess) {
    showDialog(
      context: context,
      barrierDismissible: !isSuccess,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(AppWords.tr(title, lang), style: TextStyle(color: titleColor)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              if (isSuccess) {
                Navigator.pop(context);
              }
            },
            child: Text(
              AppWords.tr(isSuccess ? "OK" : "Cancel", lang),
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  void updatePasswordAction(String lang) {
    if (currentPassword.text.isEmpty || newPassword.text.isEmpty) {
      showCustomDialog("Error", AppWords.tr('Please fill all fields', lang), lang, Colors.red, false);
      return;
    }
    context.read<AuthCubit>().changeUserPassword(currentPassword.text, newPassword.text);
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) => Text(
            AppWords.tr('Change Password', state.language),
            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          final lang = state.language;
          if (state.authError != null) {
            showCustomDialog("Error", AppWords.tr(state.authError!, lang), lang, Colors.red, false);
          } else if (state.isSuccess) {
            showCustomDialog("Success", AppWords.tr('Password updated successfully!', lang), lang, Colors.green, true);
          }
        },
        builder: (context, state) {
          final lang = state.language;

          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                CustomAuthField(controller: currentPassword, label: AppWords.tr('Current Password', lang), isPassword: true),
                const SizedBox(height: 15),
                CustomAuthField(controller: newPassword, label: AppWords.tr('New Password', lang), isPassword: true),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      elevation: 0,
                    ),
                    onPressed: state.isLoading ? null : () => updatePasswordAction(lang),
                    child: state.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            AppWords.tr('Update Password', lang),
                            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
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