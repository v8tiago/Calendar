import 'dart:ui';

import '../../domain/entities/event.dart';

class EventModel extends Event {
  EventModel({
    required super.id,
    required super.title,
    required super.description,
    required super.location,
    super.startTime,
    super.endTime,
    required super.isAllDay,
    required super.type,
  });
  
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      startTime: json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      isAllDay: json['isAllDay'],
      type: EventType(eventTypeDetail: json['typeDetail'], eventTypeColor: Color(json['typeColor'])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'isAllDay': isAllDay,
      'typeDetail': type.eventTypeDetail,
      'typeColor': type.eventTypeColor,
    };
  }
}