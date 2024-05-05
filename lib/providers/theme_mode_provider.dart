import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateNotifierProvider<ThemeModeProvider, ThemeMode>(
  (ref) => ThemeModeProvider(),
);

class ThemeModeProvider extends StateNotifier<ThemeMode> {
  ThemeModeProvider() : super(ThemeMode.light);

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
