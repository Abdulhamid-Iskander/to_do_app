import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/cubit/task_cubit/task_cubit.dart';
import 'package:to_do_app/screens/change_password_screen.dart';
import 'package:to_do_app/screens/home_screen.dart';
import 'package:to_do_app/screens/login_screen.dart';
import 'package:to_do_app/screens/profile_screen.dart';
import 'package:to_do_app/screens/signup_screen.dart';
import 'cubit/auth/auth_cubit.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => TasksCubit()), 
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignUpScreen(),
          '/home': (context) => const HomeScreen(),
          '/change-password': (context) => const ChangePasswordScreen(),
          '/profile': (context) => const ProfileScreen(),
        },
      ),
    );
  }
}