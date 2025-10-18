import 'package:evently/UI/design/design.dart';

class Event {
  String? id;

  String? creatorUserId;

  String? title;
  String? description;
  DateTime? date;
  DateTime? time;
  String? category;

  Event({
    this.id,
    this.creatorUserId,
    this.title,
    this.description,
    this.date,
    this.time,
    this.category,
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
    switch (category?.toLowerCase()) {
      case "Sports":
        return AppImages.sports;

      case "Birthday":
        return AppImages.birthday;

      case "Gaming":
        return AppImages.gaming;

      case "Workshop":
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
      'category': category,
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
      category: map?['category'],
    );
  }
}
