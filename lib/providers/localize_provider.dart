import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final languageProvider = StateNotifierProvider<LanguageController, Locale>(
  (ref) => LanguageController(),
);

enum Language { en, ja }

extension LanguageExtension on Language {
  String get value {
    switch (this) {
      case Language.en:
        return 'en';
      case Language.ja:
        return 'ja';
    }
  }
}

class LanguageController extends StateNotifier<Locale> {
  static const _keyLanguage = 'language';

  LanguageController() : super(const Locale('en')) {
    _fetchLocale();
  }

  void _fetchLocale() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final lang = sharedPreferences.getString(_keyLanguage) ?? 'en';
    state = Locale(lang);
  }

  void setLanguage(Language lang) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_keyLanguage, lang.value);
    state = Locale(lang.value);
  }
}
