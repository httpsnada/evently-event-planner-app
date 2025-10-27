import 'package:evently/UI/extensions/context_extention.dart';
import 'package:evently/UI/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../../database/EventsDao.dart';
import '../../../database/model/Category.dart';
import '../../../database/model/Event.dart';
import '../../common/CustomFormField.dart';
import '../../common/events_tabs.dart';
import '../../design/design.dart';
import '../../provider/AuthenticationProvider.dart';
import '../select_location/select_location.dart';

class EditEvent extends StatefulWidget {
  EditEvent({super.key});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  int selectedTabIndex = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<Category> categories = Category.getAllCategories(includeAll: false);
  var formKey = GlobalKey<FormState>();
  late Event event;
  double? eventLatitude;
  double? eventLongitude;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   event = ModalRoute.of(context)?.settings.arguments as Event;
  //
  //   titleController.text = event.title ?? "";
  //   descriptionController.text = event.description ?? "";
  //   selectedTabIndex = (event.categoryID ?? 1) - 1;
  //   eventLatitude = event.latitude ?? 30.0444;
  //   eventLongitude = event.longitude ?? 31.2357;
  //   selectedDate = event.date ?? DateTime.now();
  //   selectedTime = event.time != null
  //       ? TimeOfDay.fromDateTime(event.time!)
  //       : TimeOfDay.now();
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final route = ModalRoute.of(context);
      if (route != null && route.settings.arguments is Event) {
        event = route.settings.arguments as Event;

        setState(() {
          titleController.text = event.title ?? "";
          descriptionController.text = event.description ?? "";
          selectedTabIndex = (event.categoryID ?? 1) - 1;
          eventLatitude = event.latitude ?? 30.0444;
          eventLongitude = event.longitude ?? 31.2357;
          selectedDate = event.date ?? DateTime.now();
          selectedTime = event.time != null
              ? TimeOfDay.fromDateTime(event.time!)
              : TimeOfDay.now();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Event"), centerTitle: true),

      body: Padding(
        padding: EdgeInsets.all(16),
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
                      'assets/images/${categories[selectedTabIndex].title}.jpg',
                    ),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(height: 8),

                EventsTabs(categories, revered: true, selectedTabIndex, (
                  index,
                  category,
                ) {
                  setState(() {
                    selectedTabIndex = index;
                  });
                }),

                CustomFormField(
                  controller: titleController,
                  labelText: "Event Title",
                  prefixIcon: Icons.edit_note_outlined,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "please enter a title";
                    }
                  },
                ),

                CustomFormField(
                  controller: descriptionController,
                  labelText: "Event Description",
                  lines: 5,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
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
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontFamily: GoogleFonts.inter().fontFamily,
                              ),
                        ),
                      ],
                    ),

                    TextButton(
                      onPressed: () {
                        chooseDate(context);
                      },
                      child: Text(
                        selectedDate?.format() ?? "Select a date",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontFamily: GoogleFonts.inter().fontFamily,
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
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontFamily: GoogleFonts.inter().fontFamily,
                              ),
                        ),
                      ],
                    ),

                    TextButton(
                      onPressed: () {
                        chooseTime(context);
                      },
                      child: Text(
                        selectedTime != null
                            ? selectedTime!.format(context)
                            : "Select a time",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontFamily: GoogleFonts.inter().fontFamily,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                OutlinedButton(
                  onPressed: () async {
                    final picked = await Navigator.push<LatLng>(
                      context,
                      MaterialPageRoute(builder: (_) => MapSelectPage()),
                    );
                    if (picked != null) {
                      setState(() {
                        eventLatitude = picked.latitude;
                        eventLongitude = picked.longitude;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.all(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.my_location,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '${eventLatitude?.toStringAsFixed(4)}, ${eventLongitude?.toStringAsFixed(4)}',
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            updateEvent();
          },
          child: Text("Update Event"),
        ),
      ),
    );
  }

  void chooseDate(BuildContext context) async {
    final validInitialDate =
        (selectedDate != null && selectedDate!.isAfter(DateTime.now()))
        ? selectedDate!
        : DateTime.now();
    var date = await showDatePicker(
      context: context,
      initialDate: validInitialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 60)),
    );
    if (date != null && mounted) {
      setState(() {
        selectedDate = date;
        // print('$selectedDate');
      });
    }
  }

  void chooseTime(BuildContext context) async {
    var time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (time != null && mounted) {
      setState(() {
        selectedTime = time;
      });
    }
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

  void updateEvent() async {
    if (!validate()) {
      return;
    }
    var authProvider = Provider.of<AuthenticationProvider>(
      context,
      listen: false,
    );

    final updatedEvent = event.copyWith(
      title: titleController.text,
      description: descriptionController.text,
      date: selectedDate,
      time: selectedTime?.toDateTime(),
      categoryID: categories[selectedTabIndex].id,
      creatorUserId: authProvider.getUser()?.id,
      latitude: eventLatitude,
      longitude: eventLongitude,
    );

    context.showLoadingDialog(
      message: "Updating Event ...",
      isDismissable: false,
    );

    await EventsDao.updateEvent(updatedEvent);

    Navigator.pop(context);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Event updated successfully')));
    Navigator.pop(context, updatedEvent);
  }
}
