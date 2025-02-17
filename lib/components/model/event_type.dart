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
        return Colors.blue; // Cor para material Nacional
      case EventType.estadual:
        return Colors.green; // Cor para material Estadual
      case EventType.sede:
        return Colors.yellow; // Cor para material Sede
      case EventType.msj:
        return Colors.red; // Cor para material MSJ
      case EventType.mam:
        return Colors.purple; // Cor para material MAM
      default:
        return Colors.grey; // Cor padrão caso o tipo não seja encontrado
    }
  }
}