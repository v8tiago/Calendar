import 'package:flutter/material.dart';

class EventType {
  final String eventTypeDetail;
  final Color eventTypeColor;

  EventType({required this.eventTypeDetail, required this.eventTypeColor});
}

class Event {
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime? startTime;
  final DateTime? endTime;
  final bool isAllDay;
  final EventType type;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    this.startTime,
    this.endTime,
    required this.isAllDay,
    required this.type,
  });
}