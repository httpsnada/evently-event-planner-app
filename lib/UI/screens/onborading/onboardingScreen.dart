import 'package:evently/UI/common/AppLogo.dart';
import 'package:evently/UI/design/design.dart';
import 'package:flutter/material.dart';

class OnboradingScreen extends StatelessWidget {
  // static const String routeName = 'onborading' ;
  const OnboradingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.logo, width: 48, height: 48),

            SizedBox(width: 12),

            AppLogo(),
          ],
        ),
      ),
    );
  }
}
