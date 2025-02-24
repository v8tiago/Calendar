import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magic_calendar/core/model/event_type.dart';

class Event {
  final int id;
  final String title;
  final EventType type;
  final String description;
  final String location;
  final bool isAllDay;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final String date;

  Event({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.location,
    required this.isAllDay,
    required this.startTime,
    required this.endTime,
    required this.date,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      type: _eventTypeFromString(json['type'])!,
      description: json['description'],
      location: json['location'],
      isAllDay: json['isAllDay'] ?? false,
      startTime: _parseTimeOfDay(json['startTime']),
      endTime: _parseTimeOfDay(json['endTime']),
      date: json['date'],
    );
  }

  Event copyWith({
    int? id,
    String? title,
    EventType? type,
    String? description,
    String? location,
    bool? isAllDay,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    String? date,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      location: location ?? this.location,
      isAllDay: isAllDay ?? this.isAllDay,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'type': type,
      'description': description,
      'location': location,
      'isAllDay': isAllDay,
      'starTime': startTime,
      'endTime': endTime,
      'date': date,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] as int,
      title: map['title'] as String,
      type: _eventTypeFromString(map['type'] as String)!,
      description: map['description'] as String,
      location: map['location'] as String,
      isAllDay: map['isAllDay'] as bool,
      startTime:
          _parseTimeOfDay(map['startTime'] as String?), // Handle null String
      endTime: _parseTimeOfDay(map['endTime'] as String?),
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Event(id: $id, title: $title, color: $type, description: $description, location: $location, isAllDay: $isAllDay, startTime: $startTime, endTime:$endTime, date: $date)';
  }

  @override
  bool operator ==(covariant Event other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.type == type &&
        other.description == description &&
        other.location == location &&
        other.isAllDay == isAllDay &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        type.hashCode ^
        description.hashCode ^
        location.hashCode ^
        isAllDay.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        date.hashCode;
  }

  static EventType? _eventTypeFromString(String type) {
    switch (type) {
      case 'NACIONAL':
        return EventType.nacional;
      case 'ESTADUAL':
        return EventType.estadual;
      case 'SEDE':
        return EventType.sede;
    }
  }



  static TimeOfDay? _parseTimeOfDay(String? timeString) {
    if (timeString == null) return null;

    try {
      DateFormat format = DateFormat("HH:mm");
      DateTime dateTime = format.parse(timeString);
      return TimeOfDay.fromDateTime(dateTime);
    } catch (e) {
      log("Error parsing time: $e");
      return null; 
    }
  }
}
