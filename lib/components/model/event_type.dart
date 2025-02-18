import 'package:flutter/material.dart';

enum EventType {
  nacional,
  estadual,
  sede,
  msj,
  mam,
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
        return Colors.yellow;
      case EventType.msj:
        return Colors.red;
      case EventType.mam:
        return Colors.purple;
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
      case EventType.msj:
        return 'Módulo São Jorge'; 
      case EventType.mam:
        return 'Módulo Arcanjo Miguel';
      default:
        return '';
    }
  }
}