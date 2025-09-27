import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/UI/provider/LanguageProvider.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class LanguageSwitcher extends StatefulWidget {
  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {
  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    return AnimatedToggleSwitch<Locale>.rolling(
      current: languageProvider.getSelectedLocale(),
      values: languageProvider.getSupportedLocales(),
      onChanged: (item) {
        setState(() {
          languageProvider.changeLocale(item);
        });
      },
      iconBuilder: (value, foreground) {
        if (value == Locale('en')) {
          return Flag(Flags.united_states_of_america);
        } else {
          return Flag(Flags.egypt);
        }
      },
      style: ToggleStyle(
        indicatorColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.transparent,
        borderColor: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
