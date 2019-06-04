import 'package:flutter/material.dart';

class Entry implements Comparable<Entry> {
  final String title;
  final String location;
  final String description;
  DateTime date;
  TimeOfDay time;
  var imageFile;

  Entry(
    this.title,
    this.location,
    this.description,
    this.date,
    this.time,
    this.imageFile,
  );

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'location': location,
      'description': description,
      'date': date.toIso8601String(),
      'hour': time.hour,
      'minute': time.minute,
      'imageFile': imageFile
    };
  }

  int compareTo(Entry other) {
    int order = other.date.compareTo(date);
    if (order == 0) order = other.time.hour.compareTo(time.hour);
    return order;
  }
}
