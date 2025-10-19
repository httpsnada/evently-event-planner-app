import 'package:evently/UI/common/event_card.dart';
import 'package:evently/UI/provider/AuthenticationProvider.dart';
import 'package:evently/database/EventsDao.dart';
import 'package:evently/database/model/Category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  Category selectedCategory;

  HomeTab(this.selectedCategory, {super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  @override
  void didUpdateWidget(covariant HomeTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedCategory != oldWidget.selectedCategory) {
      setState(() {
        //  widget.selectedCategory = oldWidget.selectedCategory ;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider provider = Provider.of<AuthenticationProvider>(
        context, listen: false);
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: EventsDao.getRealTimeEvents(
                    widget.selectedCategory.id != 0 ? widget.selectedCategory
                        .id // a specific category is selected
                        : null // all categories tab
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
              return ListView.separated(
                  itemBuilder: (context, index) {
                    var event = events![index];
                    var isFavorite = provider.isFavorite(event);
                    event.isFav = isFavorite;
                    return EventCard(events[index]);
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                  itemCount: events?.length ?? 0);
            }),
          ),
        ],
      ),
    );
  }
}
