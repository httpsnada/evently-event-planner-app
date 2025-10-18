import 'package:evently/UI/common/event_card.dart';
import 'package:evently/database/EventsDao.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: EventsDao.getEvents(), builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(),);
              }
              else if (snapshot.hasError) {
                print("Error: ${snapshot.error}");
                return Center(child: Text("Something Went Wrong", style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,),);
              }
              var events = snapshot.data;
              return ListView.separated(
                  itemBuilder: (context, index) => EventCard(events![index]),
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                  itemCount: events?.length ?? 0);
            }),
          ),
        ],
      ),
    );
  }
}
