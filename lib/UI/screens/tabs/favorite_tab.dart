import 'package:evently/UI/common/CustomFormField.dart';
import 'package:evently/UI/common/event_card.dart';
import 'package:evently/UI/provider/AuthenticationProvider.dart';
import 'package:evently/database/EventsDao.dart';
import 'package:evently/database/model/Category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/events_tabs.dart';

class FavoriteTab extends StatefulWidget {

  FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<FavoriteTab> {

  int currentTabIndex = 0;
  List<Category> allCategories = Category.getAllCategories();

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider provider = Provider.of<AuthenticationProvider>(
        context, listen: false);
    Size size = MediaQuery.sizeOf(context);
    return Column(
      children: [

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(16),
              bottomEnd: Radius.circular(16),
            ),
            color: Theme
                .of(context)
                .colorScheme
                .primary,
          ),
          child: EventsTabs(allCategories, currentTabIndex, (index,
              category,) {
            setState(() {
              currentTabIndex = index;
            });
          }),
        ),

        Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: CustomFormField(
              labelText: "Search for event", prefixIcon: Icons.search,)),
        

        Expanded(
          child: FutureBuilder(
              future: EventsDao.getFavorites(
                  allCategories[currentTabIndex].id != 0
                      ? allCategories[currentTabIndex]
                      .id // a specific category is selected
                      : null // all categories tab
                  , provider
                  .getUser()
                  ?.favorites ?? []
              ), builder: (context, snapshot) {
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
            var events = snapshot.data?.toList();
            if (events == null || events.isEmpty == true) {
              return Center(child: Text("No Events Found", style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium,),);
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    var event = events![index];
                    var isFavorite = provider.isFavorite(event);
                    event.isFav = isFavorite;
                    return EventCard(events[index]);
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                  itemCount: events.length ?? 0),
            );
          }),
        ),
      ],
    );
  }
}
