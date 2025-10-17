import 'package:evently/UI/common/CustomFormField.dart';
import 'package:evently/UI/common/events_tabs.dart';
import 'package:evently/UI/design/design.dart';
import 'package:evently/database/model/Category.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class AddEventScreen extends StatefulWidget {
  AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  int selectedTabIndex = 0;
  List<Category> categories = Category.getAllCategories(includeAll: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Event"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 16,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image(
                        image: AssetImage(
                          'assets/images/${categories[selectedTabIndex].title}.jpg',
                        ),
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),

                    EventsTabs(categories, revered: true, selectedTabIndex, (
                      index,
                      category,
                    ) {
                      setState(() {
                        selectedTabIndex = index;
                      });
                    }),

                    CustomFormField(
                      labelText: "Event Title",
                      prefixIcon: Icons.edit_note_outlined,
                    ),
                    CustomFormField(labelText: "Event Description", lines: 5),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(FontAwesome.calendar),
                            SizedBox(width: 6),
                            Text(
                              "Event Date",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                  ),
                            ),
                          ],
                        ),

                        Text(
                          "Choose Date",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontFamily: GoogleFonts.inter().fontFamily,
                                color: AppColors.primary,
                              ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(FontAwesome.clock),
                            SizedBox(width: 6),
                            Text(
                              "Event Time",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                  ),
                            ),
                          ],
                        ),

                        Text(
                          "Choose Time",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontFamily: GoogleFonts.inter().fontFamily,
                                color: AppColors.primary,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              ElevatedButton(onPressed: () {}, child: Text("Add Event")),
            ],
          ),
        ),
      ),
    );
  }
}
