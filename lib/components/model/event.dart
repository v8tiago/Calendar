import 'dart:convert';

class Event {
  final String title;
  final String color;
  final String description;
  final String location;
  final String time;
  final String date;

  Event({
    required this.title,
    required this.color,
    required this.description,
    required this.location,
    required this.time,
    required this.date,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      color: json['color'], 
      description: json['description'],
      location: json['location'],
      time: json['time'],
      date: json['date'],
    );
  }

  Event copyWith({
    String? title,
    String? color,
    String? description,
    String? location,
    String? time,
    String? date,
  }) {
    return Event(
      title: title ?? this.title,
      color: color ?? this.color,
      description: description ?? this.description,
      location: location ?? this.location,
      time: time ?? this.time,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'color': color,
      'description': description,
      'location': location,
      'time': time,
      'date': date,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      title: map['title'] as String,
      color: map['color'] as String,
      description: map['description'] as String,
      location: map['location'] as String,
      time: map['time'] as String,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Event(title: $title, color: $color, description: $description, location: $location, time: $time, date: $date)';
  }

  @override
  bool operator ==(covariant Event other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.color == color &&
      other.description == description &&
      other.location == location &&
      other.time == time &&
      other.date == date;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      color.hashCode ^
      description.hashCode ^
      location.hashCode ^
      time.hashCode ^
      date.hashCode;
  }
}