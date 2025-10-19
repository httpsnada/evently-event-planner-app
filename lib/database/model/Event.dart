import 'package:evently/UI/design/design.dart';

class Event {
  String? id;
  String? creatorUserId;
  String? title;
  String? description;
  DateTime? date;
  DateTime? time;
  int? categoryID;
  bool isFav = false;

  Event({
    this.id,
    this.creatorUserId,
    this.title,
    this.description,
    this.date,
    this.time,
    this.categoryID,
  });

  String getMonthName(DateTime? date) {
    if (date == null) return "unknown";

    const List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[date.month - 1];
  }

  String getCategoryImage() {
    switch (categoryID) {
      case 1:
        return AppImages.sports;

      case 2:
        return AppImages.birthday;

      case 3:
        return AppImages.gaming;

      case 4:
        return AppImages.workshop;
    }
    return "";
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'creatorUserId': creatorUserId,
      'title': title,
      'description': description,
      'date': date?.millisecondsSinceEpoch,
      'time': time?.millisecondsSinceEpoch,
      'categoryID': categoryID,
    };
  }

  factory Event.fromMap(Map<String, dynamic>? map) {
    return Event(
      id: map?['id'],
      creatorUserId: map?['creatorUserId'],
      title: map?['title'],
      description: map?['description'],
      date: DateTime.fromMillisecondsSinceEpoch(map?['date']),
      time: DateTime.fromMillisecondsSinceEpoch(map?['time']),
      categoryID: map?['categoryID'],
    );
  }
}
