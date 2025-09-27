import 'package:evently/UI/common/AppSharedPreferences.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  late Locale _locale;

  AppSharedPreferences appSettingsPefrences = AppSharedPreferences.getInstace();

  LanguageProvider() {
    _locale = appSettingsPefrences.getCurrentLocale();
  }

  List<Locale> getSupportedLocales() {
    return [Locale('en'), Locale('ar')];
  }

  void changeLocale(Locale newLang) {
    _locale = newLang;
    appSettingsPefrences.saveLocale(_locale);
    notifyListeners();
  }

  Locale getSelectedLocale() {
    return _locale;
  }
}
