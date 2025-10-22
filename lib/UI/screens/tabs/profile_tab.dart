import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:evently/UI/provider/LanguageProvider.dart';
import 'package:evently/UI/provider/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProfileTab extends StatefulWidget {
  ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  List<String> language = [
    'English',
    'العربية',
  ];

  List<String> theme = [
    'Light',
    'Dark',
  ];

  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);


    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Language", style: Theme
                .of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                fontWeight: FontWeight.bold
            ),),
            CustomDropdown<String>(
                hintText: "Select Language",
                items: language,
                initialItem: language[0],
                onChanged: (value) {
                  langProvider.changeLocale(
                      value == "English" ? Locale("en") : Locale("ar"));
                  // langProvider.changeLocale(value == "English" ? "en" : "ar" ));
                },
                decoration: CustomDropdownDecoration(
                    headerStyle: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary
                    ),
                    closedBorder: Border.all(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary
                    ),
                    closedFillColor: Colors.transparent,
                    closedSuffixIcon: Icon(
                      Icons.arrow_drop_down_rounded, color: Theme
                        .of(context)
                        .colorScheme
                        .primary, size: 30,),
                    expandedBorder: Border.all(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary
                    ),
                    expandedFillColor: Colors.white,
                    expandedSuffixIcon: Icon(
                      Icons.arrow_drop_up_rounded, color: Theme
                        .of(context)
                        .colorScheme
                        .primary, size: 30,),
                    listItemStyle: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary
                    )
                )
            ),


            Text("Theme Mode", style: Theme
                .of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                fontWeight: FontWeight.bold
            ),),
            CustomDropdown<String>(
                hintText: "Select Theme",
                items: theme,
                initialItem: theme[0],
                onChanged: (value) {
                  themeProvider.changeTheme(
                      value == "Light" ? ThemeMode.light : ThemeMode.dark);
                },
                decoration: CustomDropdownDecoration(
                    headerStyle: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary
                    ),
                    closedBorder: Border.all(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary
                    ),
                    closedFillColor: Colors.transparent,
                    closedSuffixIcon: Icon(
                      Icons.arrow_drop_down_rounded, color: Theme
                        .of(context)
                        .colorScheme
                        .primary, size: 30,),
                    expandedBorder: Border.all(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary
                    ),
                    expandedFillColor: Colors.white,
                    expandedSuffixIcon: Icon(
                      Icons.arrow_drop_up_rounded, color: Theme
                        .of(context)
                        .colorScheme
                        .primary, size: 30,),
                    listItemStyle: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary
                    )
                )
            ),

          ]
      ),
    );
  }
}
