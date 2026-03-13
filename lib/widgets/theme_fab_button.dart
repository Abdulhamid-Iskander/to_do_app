import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/cubit/auth/auth_cubit.dart';

class ThemeFabButton extends StatelessWidget {
  const ThemeFabButton({super.key});

  final List<int> appColors = const [
    0xFFE91E63, // Pink 
    0xFF2196F3, // Blue
    0xFF4CAF50, // Green
    0xFF9C27B0, // Purple
    0xFFFF9800, // Orange
    0xFF009688, // Teal
    0xFF607D8B, // Blue Grey
    0xFFF44336, // Red
  ];

  void showColorPicker(BuildContext context, int currentColor) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Choose Theme', 
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(currentColor))
              ),
              const SizedBox(height: 25),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: appColors.map((color) {
                  return GestureDetector(
                    onTap: () {
                      context.read<AuthCubit>().updateThemeColor(color);
                      Navigator.pop(context); 
                    },
                    child: CircleAvatar(
                      backgroundColor: Color(color),
                      radius: 25,
                      child: currentColor == color
                          ? const Icon(Icons.check, color: Colors.white, size: 30)
                          : null,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentColor = context.watch<AuthCubit>().state.themeColor;

    return FloatingActionButton.small(
      heroTag: 'change_theme',
      onPressed: () => showColorPicker(context, currentColor),
      backgroundColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Color(currentColor), width: 1.5),
      ),
      child: Icon(Icons.palette_outlined, color: Color(currentColor)),
    );
  }
}