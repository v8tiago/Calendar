import 'dart:convert';
import 'package:magic_calendar/core/model/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventRequest {
  final String title;
  final String description;
  final String location;
  final bool isAllDay;
  final String date;
  final String? startTime;
  final String? endTime;
  final String type;

  EventRequest({
    required this.title,
    required this.description,
    required this.location,
    required this.isAllDay,
    required this.date,
    this.startTime,
    this.endTime,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'location': location,
      'isAllDay': isAllDay,
      'date': date,
      'startTime': startTime ?? '',
      'endTime': endTime ?? '',
      'type': type,
    };
  }

  static EventRequest fromEvent(Event event) {
    return EventRequest(
      title: event.title,
      description: event.description,
      location: event.location,
      isAllDay: event.isAllDay,
      date: event.date,
      startTime: event.startTime != null ? _timeOfDayToString(event.startTime!) : null,
      endTime: event.endTime != null ? _timeOfDayToString(event.endTime!) : null,
      type: event.type.name.toUpperCase(),
    );
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  static String _timeOfDayToString(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat.Hm();
    return format.format(dt);
  }
}