import 'package:evently/database/model/Category.dart';
import 'package:flutter/material.dart';

import 'TabBarItem.dart';

typedef OnTabSelected = void Function(int index, Category category);

class EventsTabs extends StatelessWidget {
  OnTabSelected onTabSelected;
  int currentTabIndex;
  List<Category> categories;
  bool revered;

  EventsTabs(
    this.categories,
    this.currentTabIndex,
    this.onTabSelected, {
    this.revered = false,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: TabBar(
        indicatorColor: Colors.transparent,
        dividerColor: Colors.transparent,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelPadding: EdgeInsets.symmetric(horizontal: 6),
        onTap: (index) {
          onTabSelected(index, categories[index]);
        },
        tabs: categories.map((category) {
          return TabBarItem(
            icon: category.icon,
            text: category.title,
            index: categories.indexOf(category),
            currentIndex: currentTabIndex,
            reverseColors: revered,
          );
        }).toList(),

        // TabBarItem(
        //   icon: FontAwesome.compass,
        //   text: "All",
        //   index: 0,
        //   currentIndex: currentTabIndex,
        // ),
        //
        // TabBarItem(
        //   icon: FontAwesome.bicycle_solid,
        //   text: "Sports",
        //   index: 1,
        //   currentIndex: currentTabIndex,
        // ),
        //
        // TabBarItem(
        //   icon: FontAwesome.cake_candles_solid,
        //   text: "Birthday",
        //   index: 2,
        //   currentIndex: currentTabIndex,
        // ),
        //
        // TabBarItem(
        //   icon: FontAwesome.gamepad_solid,
        //   text: "Gaming",
        //   index: 3,
        //   currentIndex: currentTabIndex,
        // ),
        //
        // TabBarItem(
        //   icon: FontAwesome.network_wired_solid,
        //   text: "Workshop",
        //   index: 4,
        //   currentIndex: currentTabIndex,
        // ),
      ),
    );
  }
}
