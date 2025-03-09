import 'package:flutter/material.dart';

class Event {
  String name;
  String? note;
  DateTime date;
  TimeOfDay startTime;
  TimeOfDay endTime;
  bool remindsMe;
  String? category;

  Event({
    required this.name,
    this.note,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.remindsMe = false,
    this.category,
  });
}
