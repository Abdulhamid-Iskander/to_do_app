import 'package:flutter/material.dart';

class ThemeFabButton extends StatelessWidget {
  const ThemeFabButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      heroTag: 'change_theme',
      onPressed: () {
      },
      backgroundColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE91E63), width: 1),
      ),
      child: const Icon(Icons.palette_outlined, color: Color(0xFFE91E63)),
    );
  }
}