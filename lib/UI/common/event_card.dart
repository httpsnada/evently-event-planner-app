import 'package:evently/UI/extensions/date_time_extension.dart';
import 'package:evently/UI/provider/AuthenticationProvider.dart';
import 'package:evently/database/UsersDao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/model/Event.dart';
import '../design/design.dart';

class EventCard extends StatefulWidget {
  final Event event;
  const EventCard(this.event, {super.key});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      padding: EdgeInsets.all(8),
      height: size.height * .25,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary),
        image: DecorationImage(
          image: AssetImage(widget.event.getCategoryImage()),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text("${widget.event.date?.day}", style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge),
                SizedBox(height: 4),
                Text(widget.event.date?.formatMonth() ?? " ", style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge),
              ],
            ),
          ),

          Spacer(),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.event.description ?? " ",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                    fontSize: 14,
                    // fontFamily: GoogleFonts.inter().fontFamily
                  ),
                ),
                IconButton(
                  onPressed: () {
                    toggleFavorites(widget.event);
                  },
                  icon: widget.event.isFav ? Icon(
                    Icons.favorite,
                    size: 24,
                    color: AppColors.primary,
                  ) : Icon(
                    Icons.favorite_border_rounded,
                    size: 24,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void toggleFavorites(Event event) async {
    AuthenticationProvider provider = Provider.of<AuthenticationProvider>(
        context, listen: false);
    var user = provider.getUser();
    var isFav = provider.isFavorite(event);
    if (isFav) {
      user = await UsersDao.removeFromFavorite(provider.getUser()!, event.id!);
    }
    else {
      user = await UsersDao.addToFavorite(provider.getUser()!, event.id!);
    }
    provider.updateFavorites(user.favorites);
    setState(() {
      widget.event.isFav = !isFav;
    });
  }
}
