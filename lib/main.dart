import 'package:evently/UI/common/AppSharedPreferences.dart';
import 'package:evently/UI/design/design.dart';
import 'package:evently/UI/provider/LanguageProvider.dart';
import 'package:evently/UI/provider/ThemeProvider.dart';
import 'package:evently/UI/screens/onborading/onboardingScreen.dart';
import 'package:evently/UI/screens/register/RegisterScreen.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.init();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    return MaterialApp(
      title: 'evently',
      debugShowCheckedModeBanner: false,
      home: OnboradingScreen(),
      initialRoute: AppRoutes.OnboardingScreen.routeName,
      routes: {
        AppRoutes.OnboardingScreen.routeName: (context) => OnboradingScreen(),
        AppRoutes.RegisterScreen.routeName: (context) => RegisterScreen(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: provider.getSelectedThemeMode(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: languageProvider.getSelectedLocale(),
    );
  }
}
