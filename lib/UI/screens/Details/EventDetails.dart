import 'package:evently/UI/design/design.dart';
import 'package:evently/UI/extensions/context_extention.dart';
import 'package:evently/UI/extensions/date_time_extension.dart';
import 'package:evently/UI/provider/AuthenticationProvider.dart';
import 'package:evently/database/EventsDao.dart';
import 'package:evently/database/model/Event.dart';
import 'package:evently/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class EventDetails extends StatefulWidget {
  EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  Event? event;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    event ??= ModalRoute
        .of(context)
        ?.settings
        .arguments as Event;
  }

  @override
  Widget build(BuildContext context) {
    if (event == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final double lat = event!.latitude ?? 30.0444;
    final double lng = event!.longitude ?? 31.2357;
    final LatLng initialPosition = LatLng(lat, lng);
    final authProvider = Provider.of<AuthenticationProvider>(
      context,
      listen: false,
    );
    final currentUserId = authProvider
        .getUser()
        ?.id;
    bool isCreator = (event!.creatorUserId == currentUserId) ? true : false;

    final Set<Marker> markers = {};
    if (event!.latitude != null && event!.longitude != null) {
      markers.add(
        Marker(
          markerId: const MarkerId("event_location"),
          position: initialPosition,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
        centerTitle: true,
        actions: isCreator
            ? [
          IconButton(
            onPressed: () async {
              final updatedEvent = await Navigator.pushNamed(
                context,
                AppRoutes.EditEvent.routeName,
                arguments: event,
              ) as Event?;

              if (updatedEvent != null) {
                setState(() {
                  event = updatedEvent;
                });
              }
            },
            icon: Icon(
              Icons.edit_outlined,
              size: 24,
              color: AppColors.primary,
            ),
          ),

          IconButton(
            onPressed: () {
              context.showMessage(
                  "You want to delete this event?",
                  posActionText: "Delete",
                  onPosActionClick: () async {
                    await EventsDao().deleteEvent(event!.id!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Event deleted successfully')),
                    );
                    Navigator.pop(context);
                  },
                  negActionText: "Cancel"
              );
            },
            icon: Icon(
              Icons.delete_outline,
              size: 24,
              color: Color(0xFFFF5659),
            ),
          ),
        ]
            : null,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  event!.getCategoryImage(),
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),

              Text(
                event!.title ?? "",
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                  fontFamily: GoogleFonts
                      .inter()
                      .fontFamily,
                  fontSize: 24,
                ),
              ),

              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),

                    SizedBox(width: 8),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event!.date?.formatFullDate() ?? "",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.primary),
                        ),

                        SizedBox(height: 4),

                        Text(
                          event!.time?.formatTime() ?? "",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: initialPosition,
                          zoom: 14,
                        ),
                        markers: markers,
                        zoomControlsEnabled: false,
                        myLocationButtonEnabled: false,
                      ),
                    ],
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    event!.description ?? "",
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

