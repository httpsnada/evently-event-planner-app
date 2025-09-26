import 'package:evently/UI/design/design.dart';
import 'package:evently/UI/screens/onborading/onboardingScreen.dart';
import 'package:evently/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'evently',
      debugShowCheckedModeBanner: false,
      home: OnboradingScreen(),
      initialRoute: AppRoutes.OnboardingScreen.routeName,
      routes: {
        AppRoutes.OnboardingScreen.routeName: (context) => OnboradingScreen(),
      },
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
    );
  }
}
