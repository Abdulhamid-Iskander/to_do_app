import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Image(
          image: AssetImage('assets/images/logo.png'),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.person_outline, color: Theme.of(context).iconTheme.color),
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