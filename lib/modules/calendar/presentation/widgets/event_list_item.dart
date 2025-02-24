import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/event.dart';

class EventListItem extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;

  const EventListItem({super.key, required this.event, required this.onTap});

  @override
  Widget build(BuildContext context) {
    String startTime = event.isAllDay ? '' : DateFormat.jm().format(event.startTime!);
    String endTime = event.isAllDay ? '' : DateFormat.jm().format(event.endTime!);
    bool isAllDay = event.isAllDay;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        color: event.type.eventTypeColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: onTap,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize:18.0, color: Colors.white),
              softWrap: true,
            ),
            const SizedBox(height: 10),
            if (isAllDay)
              Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.white70),
                  const SizedBox(width: 5),
                  const Text("Dia Todo", style: TextStyle(color: Colors.white)),
                  const SizedBox(width: 10),
                  const Icon(Icons.location_on, color: Colors.white70),
                  const SizedBox(width: 5),
                  Text(event.location, style: TextStyle(color: Colors.white)),
                ],
              )
            else
              Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.white70),
                  const SizedBox(width: 5),
                  Text(startTime, style: const TextStyle(color: Colors.white)),
                  const Text(' - ', style: TextStyle(color: Colors.white)),
                  Text(endTime, style: const TextStyle(color: Colors.white)),
                  const SizedBox(width: 10),
                  const Icon(Icons.location_on, color: Colors.white70),
                  const SizedBox(width: 5),
                  Text(event.location, style: TextStyle(color: Colors.white)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}