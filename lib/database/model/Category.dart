import 'package:flutter/cupertino.dart';
import 'package:icons_plus/icons_plus.dart';

class Category {
  int id;

  String title;

  IconData icon;

  Category({required this.id, required this.title, required this.icon});

  static List<Category> getAllCategories({bool includeAll = true}) {
    List<Category> list = [];

    if (includeAll) {
      list.add(Category(id: 0, icon: FontAwesome.compass, title: "All"));
    }

    list.addAll([
      Category(id: 1, icon: FontAwesome.bicycle_solid, title: "Sport"),

      Category(id: 2, icon: FontAwesome.cake_candles_solid, title: "Birthday"),

      Category(id: 3, icon: FontAwesome.gamepad_solid, title: "Gaming"),

      Category(id: 4, icon: FontAwesome.network_wired_solid, title: "Workshop"),
    ]);
    return list;
  }
}
