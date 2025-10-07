import 'package:evently/UI/common/AppSharedPreferences.dart';
import 'package:evently/UI/design/design.dart';
import 'package:evently/UI/provider/AuthenticationProvider.dart';
import 'package:evently/UI/provider/LanguageProvider.dart';
import 'package:evently/UI/provider/ThemeProvider.dart';
import 'package:evently/UI/screens/home/HomeScreen.dart';
import 'package:evently/UI/screens/login/LoginScreen.dart';
import 'package:evently/UI/screens/onborading/onboardingScreen.dart';
import 'package:evently/UI/screens/register/RegisterScreen.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppSharedPreferences.init();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider())
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
        AppRoutes.LoginScreen.routeName: (context) => LoginScreen(),
        AppRoutes.HomeScreen.routeName: (context) => HomeScreen(),
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
