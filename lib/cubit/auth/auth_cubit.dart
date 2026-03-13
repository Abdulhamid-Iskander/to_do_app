import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final currentLanguage = state.language; 
    final currentColor = state.themeColor;
    
    await prefs.clear(); 
    await FirebaseAuth.instance.signOut();
    
    await prefs.setString('language', currentLanguage);
    await prefs.setInt('themeColor', currentColor);
    
    emit(AuthState(language: currentLanguage, themeColor: currentColor)); 
  }
}