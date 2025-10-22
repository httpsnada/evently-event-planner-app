import 'package:evently/UI/common/CustomFormField.dart';
import 'package:evently/UI/common/events_tabs.dart';
import 'package:evently/UI/design/design.dart';
import 'package:evently/UI/extensions/context_extention.dart';
import 'package:evently/UI/extensions/date_time_extension.dart';
import 'package:evently/UI/provider/AuthenticationProvider.dart';
import 'package:evently/database/EventsDao.dart';
import 'package:evently/database/model/Category.dart';
import 'package:evently/database/model/Event.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  int selectedTabIndex = 0;
  List<Category> categories = Category.getAllCategories(includeAll: false);
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text("Create Event"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 8,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image(
                    image: AssetImage(
                      'assets/images/${categories[selectedTabIndex]
                          .title}.jpg',
                    ),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(height: 8),


                EventsTabs(
                    categories, revered: true, selectedTabIndex, (index,
                    category,) {
                  setState(() {
                    selectedTabIndex = index;
                  });
                }),

                CustomFormField(
                  controller: titleController,
                  labelText: "Event Title",
                  prefixIcon: Icons.edit_note_outlined,
                  validator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return "please enter a title";
                    }
                  },
                ),
                CustomFormField(
                  controller: descriptionController,
                  labelText: "Event Description",
                  lines: 5,
                  validator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return "please enter a description";
                    }
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(FontAwesome.calendar),
                        SizedBox(width: 6),
                        Text(
                          "Event Date",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                            fontFamily:
                            GoogleFonts
                                .inter()
                                .fontFamily,
                          ),
                        ),
                      ],
                    ),

                    TextButton(
                      onPressed: () {
                        chooseDate(context);
                      },
                      child: Text(
                        selectedDate == null
                            ? "Choose Date"
                            : selectedDate?.format() ?? "",

                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                          fontFamily: GoogleFonts
                              .inter()
                              .fontFamily,
                          color: AppColors.primary,
                        ),
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
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                            fontFamily:
                            GoogleFonts
                                .inter()
                                .fontFamily,
                          ),
                        ),
                      ],
                    ),

                    TextButton(
                      onPressed: () {
                        chooseTime(context);
                      },
                      child: Text(
                        selectedTime == null
                            ? "Choose Time"
                            : selectedTime?.format(context) ?? "",
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                          fontFamily: GoogleFonts
                              .inter()
                              .fontFamily,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                // TextFormField(
                //   readOnly: true,
                //   enabled: false,
                //   decoration: InputDecoration(
                //     labelText: "Choose Event Location",
                //     prefixIcon: Container(
                //       width: 40,
                //         height: 40,
                //         decoration: BoxDecoration(
                //           color: AppColors.primary,
                //           borderRadius: BorderRadius.circular(8),
                //         ),
                //         child: Icon(Icons.my_location,color: Colors.white,size: 24, )),
                //         suffixIcon: IconButton(
                //         onPressed: (){}
                //         ,icon: Icon(Icons.arrow_forward_ios_outlined , color: AppColors.primary, size: 24,)),
                //         labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                //        color: AppColors.primary,
                //     ),
                //     border: OutlineInputBorder(
                //       borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                //       borderRadius: BorderRadius.circular(16),
                //     ),
                //     contentPadding: EdgeInsets.all(20),
                //   ),
                // )

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            createEvent();
          },
          child: Text("Add Event"),
        ),
      ),
    );
  }

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  void chooseDate(BuildContext context) async {
    var date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 60)),
    );
    setState(() {
      selectedDate = date;
    });
  }

  void chooseTime(BuildContext context) async {
    var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    setState(() {
      selectedTime = time;
    });
  }

  bool validate() {
    var isValid = formKey.currentState?.validate() ?? false;
    if (selectedDate == null) {
      //show error
      context.showMessage("Please choose event date");
      isValid = false;
    }
    if (selectedTime == null) {
      //show error
      context.showMessage("Please choose event time");
      isValid = false;
    }

    return isValid;
  }

  void createEvent() async {
    validate();
    if (!validate()) {
      return;
    }
    //show loading dialog
    var authProvider = Provider.of<AuthenticationProvider>(
        context, listen: false);
    var event = Event(
        title: titleController.text,
        description: descriptionController.text,
        date: selectedDate,
        time: selectedTime?.toDateTime(),
        categoryID: categories[selectedTabIndex].id,
        creatorUserId: authProvider
            .getUser()
            ?.id
    );
    context.showLoadingDialog(
        message: "Creating Event ...", isDismissable: false);
    await EventsDao.addEvent(event);
    //hide loading dialog
    Navigator.pop(context);
    context.showMessage("Event created successfully ...",
        posActionText: "Ok",
        onPosActionClick: () {
          Navigator.pop(context);
        });
  }


}
