import 'package:animate_do/animate_do.dart';
import 'package:evently/UI/common/AppLogo.dart';
import 'package:evently/UI/design/design.dart';
import 'package:evently/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            ElasticIn(
              duration: Duration(seconds: 5),
              child: Image.asset(AppImages.logo, fit: BoxFit.cover, width: 136),
              onFinish: (direction) {
                final isLoggedIn = FirebaseAuth.instance.currentUser != null;
                Navigator.pushReplacementNamed(
                  context,
                  isLoggedIn
                      ? AppRoutes.HomeScreen.routeName
                      : AppRoutes.OnboardingScreen.routeName,
                );
              },
            ),
            AppLogo(),
            Spacer(),
            Image.asset(AppImages.branding, fit: BoxFit.cover, width: 214),
          ],
        ),
      ),
    );
  }
}
