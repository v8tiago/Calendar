// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:login/components/services/event_service.dart';
import 'package:table_calendar/table_calendar.dart';

/// Example event class.
// class Event {
//   final String title;
//   final MaterialColor color;
//   final String? description;
//   final String? location;
//   final String? time;
//   final DateTime date;

//   const Event(this.title, this.color, this.description, this.location, this.time, this.date);

//   @override
//   String toString() => title;
// }

// final kEvents = LinkedHashMap<DateTime, List<Event>>(
//   equals: isSameDay,
//   hashCode: getHashCode,
// )..addAll({
//   kToday.subtract(const Duration(days: 2)): [
//       Event(
//         "Encontro Bodhidharma Ipatinga",
//         Colors.purple,
//         "Atividade será realizada no salão de eventos do Hotel San Diego, localizado na Avenida Brasil, 478, no Centro de Ipatinga.",
//         "Hotel San Diego",
//         "19:00",
//         DateTime(kToday.year, kToday.month, kToday.day - 2),
//       ),
//   ],
//     kToday: [
//       Event(
//         "Encontro Bodhidharma Ipatinga",
//         Colors.orange,
//         "Atividade será realizada no salão de eventos do Hotel San Diego, localizado na Avenida Brasil, 478, no Centro de Ipatinga.",
//         "Hotel San Diego",
//         "19:00",
//         DateTime(kToday.year, kToday.month, kToday.day),
//       ),
//        Event(
//         "Clube de Leitura",
//         Colors.pink,
//         "O Clube da Leitura é um projeto que visa incentivar a leitura e a troca de experiências entre os participantes.",
//         "Biblioteca",
//         "14:00",
//                 DateTime(kToday.year, kToday.month, kToday.day)
//       ),
//       Event(
//         "Encontro Bodhidharma Ipatinga",
//         Colors.orange,
//         "Atividade será realizada no salão de eventos do Hotel San Diego, localizado na Avenida Brasil, 478, no Centro de Ipatinga.",
//         "Hotel San Diego",
//         "19:00",
//                         DateTime(kToday.year, kToday.month, kToday.day)
//       ),
//       Event(
//         "Palestra Giordano Bruno",
//         Colors.grey,
//         "A palestra será ministrada pelo professor Helder",
//         "Auditório",
//         "19:00",
//                         DateTime(kToday.year, kToday.month, kToday.day)
//       ),
//       Event(
//         "Reunião Nacional dos Instrutores",
//         Colors.blue,
//         "Reunião Nacional dos Instrutores",
//         "MSJ",
//         "19:00",
//                         DateTime(kToday.year, kToday.month, kToday.day)
//       ),
//       Event(
//         "Reunião Nacional dos Instrutores",
//         Colors.blue,
//                 "Reunião Nacional dos Instrutores",
//         "MSJ",
//         "19:00",
//                         DateTime(kToday.year, kToday.month, kToday.day)
//       ),
//       Event(
//         "Reunião Nacional dos Instrutores",
//         Colors.blue,
//         "Reunião Nacional dos Instrutores",
//         "MSJ",
//         "19:00",
//                         DateTime(kToday.year, kToday.month, kToday.day)
//       ),
//     ],
//   });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 5, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 5, kToday.day);
