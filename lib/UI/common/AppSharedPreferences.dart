import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static const String themeKey = "theme";

  static const String light = "light";

  static const String dark = "dark";

  late SharedPreferences _appSharedPreferences;

  AppSharedPreferences._() //private constructor
  {}

  static AppSharedPreferences? _mostRecentProvider = null;

  static Future<void> init() async {
    if (_mostRecentProvider == null) {
      _mostRecentProvider = AppSharedPreferences._();
      await _mostRecentProvider?._initSharedPreferences();
    }
  }

  Future<void> saveTheme(ThemeMode mode) async {
    var themeName = mode == ThemeMode.light ? light : dark;
    await _appSharedPreferences.setString(themeKey, themeName);
  }

  ThemeMode getCurrentTheme() {
    var themeName = _appSharedPreferences.getString(themeKey);
    return themeName == dark ? ThemeMode.dark : ThemeMode.light;
  }

  static AppSharedPreferences getInstace() {
    if (_mostRecentProvider == null) {
      throw Exception("MostRecentProvider is not initialized");
    }
    return _mostRecentProvider!;
  }

  Future<void> _initSharedPreferences() async {
    _appSharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveLocale(Locale locale) async {
    await _appSharedPreferences.setString("locale", locale.languageCode);
  }

  Locale getCurrentLocale() {
    var langCode = _appSharedPreferences.getString("locale");
    return langCode == null
        ? Locale('en')
        : Locale.fromSubtags(languageCode: langCode);
  }
}
