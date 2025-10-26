import 'package:evently/UI/common/event_card.dart';
import 'package:evently/UI/provider/AuthenticationProvider.dart';
import 'package:evently/database/EventsDao.dart';
import 'package:evently/database/model/Category.dart';
import 'package:evently/database/model/Event.dart';
import 'package:evently/routes.dart';
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
  final TextEditingController _searchController = TextEditingController();
  List<Event>? allFavEvents = [];
  List<Event>? filteredEvents = [];


  @override
  Widget build(BuildContext context) {
    AuthenticationProvider provider = Provider.of<AuthenticationProvider>(
        context, listen: false);
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

        SizedBox(height: 8,),


        Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: "Search for event",
              prefixIcon: Icon(Icons.search),
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  filteredEvents = List.from(allFavEvents!);
                } else {
                  filteredEvents = allFavEvents!
                      .where((event) =>
                      event.title!.toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                }
              });
            },
          ),
        ),

        Expanded(
          child: FutureBuilder<List<Event>>(
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


            allFavEvents = snapshot.data ?? [];
            if (_searchController.text.isEmpty) {
              filteredEvents = List.from(allFavEvents!);
            } else {
              filteredEvents = allFavEvents
              !.where((e) =>
                  e.title
                  !.toLowerCase()
                      .contains(_searchController.text.toLowerCase()))
                  .toList();
            }

            if (filteredEvents!.isEmpty) {
              return Center(
                child: Text(
                  "No Events Found",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium,
                ),
              );
            }


            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    if (index >= filteredEvents!.length) return SizedBox();
                    var event = filteredEvents![index];
                    var isFavorite = provider.isFavorite(event);
                    event.isFav = isFavorite;
                    // return EventCard(events[index]);
                    return EventCard(event,
                      onTap: () {
                        Navigator.pushNamed(context,
                            AppRoutes.EventDetails.routeName, arguments: event);
                      },);
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                  itemCount: filteredEvents!.length ?? 0),
            );
          }),
        ),
      ],
    );
  }
}
