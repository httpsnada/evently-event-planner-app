import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/UI/design/design.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Event {
  String? id;
  String? creatorUserId;
  String? title;
  String? description;
  DateTime? date;
  DateTime? time;
  int? categoryID;
  final double? latitude;
  final double? longitude;
  bool isFav = false;

  Event({
    this.id,
    this.creatorUserId,
    this.title,
    this.description,
    this.date,
    this.time,
    this.categoryID,
    this.latitude,
    this.longitude,
  });

  Event copyWith({
    String? id,
    String? creatorUserId,
    String? title,
    String? description,
    DateTime? date,
    DateTime? time,
    int? categoryID,
    double? latitude,
    double? longitude,
  }) {
    return Event(
      id: id ?? this.id,
      creatorUserId: creatorUserId ?? this.creatorUserId,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      categoryID: categoryID ?? this.categoryID,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

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
    final map = <String, dynamic>{
      'id': id,
      'creatorUserId': creatorUserId,
      'title': title,
      'description': description,
      'date': date?.millisecondsSinceEpoch,
      'time': time?.millisecondsSinceEpoch,
      'categoryID': categoryID,
    };

    if (latitude != null && longitude != null) {
      map['latitude'] = latitude;
      map['longitude'] = longitude;
      map['geo_point'] = GeoPoint(latitude!, longitude!); // Firestore geo
    }

    return map;
  }

  factory Event.fromMap(Map<String, dynamic>? map) {
    final data = map ?? <String, dynamic>{};

    final geo = data['geo_point'];
    GeoPoint? gp;
    if (geo is GeoPoint) {
      gp = geo;
    } else {
      gp = null;
    }

    double? lat;
    double? lng;

    if (gp != null) {
      lat = gp.latitude;
      lng = gp.longitude;
    } else {
      final rawLat = data['latitude'];
      final rawLng = data['longitude'];

      if (rawLat is num) lat = rawLat.toDouble();
      if (rawLng is num) lng = rawLng.toDouble();
    }

    return Event(
      id: map?['id'],
      creatorUserId: map?['creatorUserId'],
      title: map?['title'],
      description: map?['description'],
      date: DateTime.fromMillisecondsSinceEpoch(map?['date']),
      time: DateTime.fromMillisecondsSinceEpoch(map?['time']),
      categoryID: map?['categoryID'],
      latitude: lat,
      longitude: lng,
    );
  }

  LatLng? get latLng => latitude != null && longitude != null
      ? LatLng(latitude!, longitude!)
      : null;
}
