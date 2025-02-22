import 'package:flutter/material.dart';

enum EventType {
  nacional,
  estadual,
  sede,
  other,
}

extension EventTypeExtension on EventType {
  Color get eventTypeColor {
    switch (this) {
      case EventType.nacional:
        return Colors.blue; 
      case EventType.estadual:
        return Colors.green;
      case EventType.sede:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String get eventTypeDetail {
    switch (this) {
      case EventType.nacional:
        return 'Nacional';
      case EventType.estadual:
        return 'Estadual'; 
      case EventType.sede:
        return 'Sede'; 
      default:
        return 'Outros';
    }
  }
}