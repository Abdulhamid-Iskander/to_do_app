import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState()) {
    _loadData(); 
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    emit(state.copyWith(
      name: prefs.getString('name') ?? 'User Name',
      email: prefs.getString('email') ?? 'Email',
      language: prefs.getString('language') ?? 'English',
      themeColor: prefs.getInt('themeColor') ?? 0xFFE91E63,
      isDarkMode: prefs.getBool('isDarkMode') ?? false,
    ));
  }

  Future<void> updateName(String newName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', newName);
    emit(state.copyWith(name: newName));
  }

  Future<void> updateEmail(String newEmail) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', newEmail);
    emit(state.copyWith(email: newEmail));
  }

  Future<void> updateLanguage(String newLanguage) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', newLanguage);
    emit(state.copyWith(language: newLanguage));
  }

  Future<void> updateThemeColor(int newColor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeColor', newColor);
    emit(state.copyWith(themeColor: newColor));
  }

  Future<void> updateThemeMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
    emit(state.copyWith(isDarkMode: isDark));
  }

  Future<void> loginUser(String email, String password) async {
    emit(state.copyWith(isLoading: true, authError: null, isSuccess: false));

    try {
      UserCredential cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      
      final doc = await FirebaseFirestore.instance.collection('users').doc(cred.user!.uid).get();
      if (doc.exists) {
        await updateName(doc.data()?['name'] ?? 'User Name');
      }
      await updateEmail(email.trim());
      
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } on FirebaseAuthException catch (e) {
      String message = "An error occurred";
      if (e.code == 'user-not-found') {
        message = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        message = "Wrong password provided.";
      }
      emit(state.copyWith(isLoading: false, authError: message));
    } catch (e) {
      emit(state.copyWith(isLoading: false, authError: e.toString()));
    }
  }

  Future<void> registerUser(String name, String email, String password) async {
    emit(state.copyWith(isLoading: true, authError: null, isSuccess: false));

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'name': name.trim(),
        'email': email.trim(),
        'uID': userCredential.user!.uid,
      });

      await updateName(name.trim());
      await updateEmail(email.trim());

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(isLoading: false, authError: e.message ?? "An error occurred"));
    } catch (e) {
      emit(state.copyWith(isLoading: false, authError: e.toString()));
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final currentLanguage = state.language; 
    final currentColor = state.themeColor;
    final currentMode = state.isDarkMode;
    
    await prefs.clear(); 
    await FirebaseAuth.instance.signOut();
    
    await prefs.setString('language', currentLanguage);
    await prefs.setInt('themeColor', currentColor);
    await prefs.setBool('isDarkMode', currentMode);
    
    emit(AuthState(
      language: currentLanguage, 
      themeColor: currentColor,
      isDarkMode: currentMode,
    )); 
  }
  Future<void> changeUserPassword(String currentPassword, String newPassword) async {
    emit(state.copyWith(isLoading: true, authError: null, isSuccess: false));
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && user.email != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPassword);
        emit(state.copyWith(isLoading: false, isSuccess: true));
      }
    } on FirebaseAuthException catch (e) {
      String message = "An error occurred";
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        message = "Current password is incorrect";
      } else if (e.code == 'weak-password') {
        message = "The new password is too weak";
      }
      emit(state.copyWith(isLoading: false, authError: message));
    } catch (e) {
      emit(state.copyWith(isLoading: false, authError: e.toString()));
    }
  }
}