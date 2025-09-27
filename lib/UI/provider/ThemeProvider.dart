import 'package:evently/UI/common/AppSharedPreferences.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeMode _themeMode;

  AppSharedPreferences appSettingsPefrences = AppSharedPreferences.getInstace();

  ThemeProvider() {
    _themeMode = appSettingsPefrences.getCurrentTheme();
  }

  List<ThemeMode> getModes() {
    return [ThemeMode.light, ThemeMode.dark];
  }

  void changeTheme(ThemeMode newTheme) {
    _themeMode = newTheme;
    appSettingsPefrences.saveTheme(_themeMode);
    notifyListeners();
  }

  ThemeMode getSelectedThemeMode() {
    return _themeMode;
  }
}
