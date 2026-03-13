import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/cubit/auth/auth_cubit.dart';
import 'package:to_do_app/cubit/auth/auth_state.dart';
import 'package:to_do_app/core/app_words.dart';

class ThemeFabButton extends StatelessWidget {
  const ThemeFabButton({super.key});

  final List<int> appColors = const [
    0xFFE91E63, 
    0xFF2196F3, 
    0xFF4CAF50, 
    0xFF9C27B0, 
    0xFFFF9800, 
    0xFF009688, 
    0xFF607D8B, 
    0xFFF44336, 
  ];

  void showColorPicker(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (ctx) {
        return BlocProvider.value(
          value: authCubit,
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              final bgColor = Theme.of(context).scaffoldBackgroundColor;
              
              return Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                ),
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppWords.tr('Dark Mode', state.language),
                          style: TextStyle(
                            fontSize: 18, 
                            fontWeight: FontWeight.bold, 
                            color: Color(state.themeColor),
                          ),
                        ),
                        Switch(
                          value: state.isDarkMode,
                          activeColor: Color(state.themeColor),
                          onChanged: (value) {
                            context.read<AuthCubit>().updateThemeMode(value);
                          },
                        ),
                      ],
                    ),
                    const Divider(height: 30),
                    Text(
                      AppWords.tr('Choose Theme', state.language), 
                      style: TextStyle(
                        fontSize: 20, 
                        fontWeight: FontWeight.bold, 
                        color: Color(state.themeColor),
                      ),
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
                          },
                          child: CircleAvatar(
                            backgroundColor: Color(color),
                            radius: 25,
                            child: state.themeColor == color
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
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentColor = Theme.of(context).primaryColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FloatingActionButton.small(
      heroTag: 'change_theme',
      onPressed: () => showColorPicker(context),
      backgroundColor: isDark ? Colors.grey[800] : Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: currentColor, width: 1.5),
      ),
      child: Icon(Icons.palette_outlined, color: currentColor),
    );
  }
}