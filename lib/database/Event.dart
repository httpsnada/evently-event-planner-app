import 'package:evently/UI/design/design.dart';

class Event {
  String? description;
  DateTime? date;
  String? category;
  bool? isFav;

  Event({
    required this.description,
    required this.date,
    required this.category,
    required this.isFav,
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

  static String getCategoryImage(String cat) {
    switch (cat.toLowerCase()) {
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
}
