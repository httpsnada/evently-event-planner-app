import 'package:evently/UI/common/AppLogo.dart';
import 'package:evently/UI/design/design.dart';
import 'package:flutter/material.dart';

class CustomLayout extends StatelessWidget {
  String image;
  String mainText;
  String subText;

  CustomLayout({
    required this.image,
    required this.mainText,
    required this.subText,
  });

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

      body: Column(
        children: [
          SizedBox(height: 12),
          Expanded(child: Image.asset(image)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(mainText, style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 8),
                  Text(subText, style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
