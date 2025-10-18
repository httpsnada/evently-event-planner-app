import 'package:evently/UI/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

import '../../database/model/Event.dart';
import '../design/design.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard(this.event, {super.key});

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
          image: AssetImage(event.getCategoryImage()),
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
                Text("${event.date?.day}", style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge),
                SizedBox(height: 4),
                Text(event.date?.formatMonth() ?? " ", style: Theme
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
                  event.description ?? " ",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    // fontFamily: GoogleFonts.inter().fontFamily
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
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
}
