import 'package:flutter/material.dart';

/// Custom AppBar for the HomeScreen.
/// Displays the application logo and profile icon.
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Image(
          image: AssetImage('assets/images/logo.png'),
        ),
      ),
      actions: [
        IconButton(
  icon: const Icon(Icons.person_outline),
  onPressed: () {
    Navigator.pushNamed(context, '/profile');
  },
)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}