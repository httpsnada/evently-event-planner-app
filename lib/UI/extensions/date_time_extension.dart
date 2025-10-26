import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String format() {
    final DateFormat customFormat = DateFormat('yyyy/MM/dd');
    // final DateFormat customFormat = DateFormat('yyyy/MMM/dd');  used to show the month's name
    return customFormat.format(this);
  }

  String formatMonth() {
    final DateFormat customFormat = DateFormat('MMM');
    return customFormat.format(this);
  }

  String formatFullDate() {
    final DateFormat customFormat = DateFormat('d MMMM yyyy');
    return customFormat.format(this);
  }

  String formatTime() {
    final DateFormat customFormat = DateFormat('hh:mm a');
    return customFormat.format(this);
  }
}

extension TimeExtension on TimeOfDay {
  DateTime toDateTime() {
    return DateTime(0, 0, 0, hour, minute);
  }
}
