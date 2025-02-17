import 'dart:convert';

import 'package:login/components/model/event_type.dart';

class Event {
  final String title;
  final EventType type;
  final String description;
  final String location;
  final String time;
  final String date;

  Event({
    required this.title,
    required this.type,
    required this.description,
    required this.location,
    required this.time,
    required this.date,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      type: _eventTypeFromString(json['type']), 
      description: json['description'],
      location: json['location'],
      time: json['time'],
      date: json['date'],
    );
  }

  Event copyWith({
    String? title,
    EventType? type,
    String? description,
    String? location,
    String? time,
    String? date,
  }) {
    return Event(
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      location: location ?? this.location,
      time: time ?? this.time,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'type': type,
      'description': description,
      'location': location,
      'time': time,
      'date': date,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      title: map['title'] as String,
      type: _eventTypeFromString(map['type'] as String),
      description: map['description'] as String,
      location: map['location'] as String,
      time: map['time'] as String,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Event(title: $title, color: $type, description: $description, location: $location, time: $time, date: $date)';
  }

  @override
  bool operator ==(covariant Event other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.type == type &&
      other.description == description &&
      other.location == location &&
      other.time == time &&
      other.date == date;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      type.hashCode ^
      description.hashCode ^
      location.hashCode ^
      time.hashCode ^
      date.hashCode;
  }

  static EventType _eventTypeFromString(String type) {
    switch (type) {
      case 'NACIONAL':
        return EventType.nacional;
      case 'ESTADUAL':
        return EventType.estadual;
      case 'SEDE':
        return EventType.sede;
      case 'MSJ':
        return EventType.msj;
      case 'MAM':
        return EventType.mam;
      default:
        return EventType.other; // Or throw an exception for invalid values
    }
  }

  static String _eventTypeToString(EventType type) {
    switch (type) {
      case EventType.nacional:
        return 'NACIONAL';
      case EventType.estadual:
        return 'ESTADUAL';
      case EventType.sede:
        return 'SEDE';
      case EventType.msj:
        return 'MSJ';
      case EventType.mam:
        return 'MAM';
      default:
        return 'other';
    }
  }
}