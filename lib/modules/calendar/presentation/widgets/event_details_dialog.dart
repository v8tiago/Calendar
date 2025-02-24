import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/event.dart';
import 'popup_details.dart'; // Certifique-se de ter este widget

class EventDetailsDialog extends StatelessWidget {
  final Event event;
  final VoidCallback onEventDeleted;

  const EventDetailsDialog({super.key, required this.event, required this.onEventDeleted});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            child: Text(event.title, textAlign: TextAlign.center),
          ),
          Divider(color: event.type.eventTypeColor, thickness: 2.0),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...[
            PopupDetails(type: 'Descrição: ', value: event.description),
            SizedBox(height: 15.0),
          ],
          ...[
            PopupDetails(type: 'Local: ', value: event.location),
            SizedBox(height: 15.0),
          ],
          if (event.isAllDay) ...[
            PopupDetails(type: 'Dia Todo: ', value: 'Sim'),
            SizedBox(height: 8.0),
          ] else ...[
            PopupDetails(
              type: 'Horário Início: ',
              value: DateFormat.jm().format(event.startTime!),
            ),
            SizedBox(height: 8.0),
            PopupDetails(
              type: 'Horário Fim: ',
              value: DateFormat.jm().format(event.endTime!),
            ),
            SizedBox(height: 8.0),
          ],
          ...[
            PopupDetails(type: 'Tipo: ', value: event.type.eventTypeDetail),
            SizedBox(height: 15.0),
          ],
        ],
      ),
      actions: <Widget>[
        Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Excluir', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              onPressed: () {
                onEventDeleted();
                Navigator.of(context).pop();
              },
            ),
            Spacer(),
            TextButton(
              child: Text('Fechar', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }
}