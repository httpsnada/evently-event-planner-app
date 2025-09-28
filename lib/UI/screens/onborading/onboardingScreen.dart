import 'package:evently/UI/common/AppLogo.dart';
import 'package:evently/UI/common/LanguageSwitcher.dart';
import 'package:evently/UI/common/ThemeSwitcher.dart';
import 'package:evently/UI/design/design.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/routes.dart';
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
      body: Column(
        children: [
          SizedBox(height: 12,),
          Expanded(child: Image.asset(AppImages.onboarding_1)),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(AppLocalizations.of(context)!.onboardingScreenTitle,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge,),
                SizedBox(height: 8,),

                Text(AppLocalizations.of(context)!.onboardingScreenSubtitle,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium,),
                SizedBox(height: 8,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.theme,
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                        fontWeight: FontWeight.w100,
                      ),
                      textAlign: TextAlign.start,),

                    ThemeSwitcher(),
                  ],
                ),
                SizedBox(height: 16,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.language,
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                        fontWeight: FontWeight.w100,
                      ),
                      textAlign: TextAlign.start,),

                    LanguageSwitcher(),
                  ],
                ),
                Spacer(),atedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.RegisterScreen.routeName,
                      );
                    },
                    chichild: Text(AppLocalizations.of(context)!.letsStart))

              ],
            ),
          )),

        ],
      ),
    );
  }
}
