import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/components/model/event.dart';
import 'package:login/components/model/event_type.dart';
import 'package:login/components/services/event_service.dart';

class AddEventDialog extends StatefulWidget {
  final Function(Event) onAddEvent;

  const AddEventDialog({required this.onAddEvent, Key? key}) : super(key: key);

  @override
  _AddEventDialogState createState() => _AddEventDialogState();
}

class _AddEventDialogState extends State<AddEventDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _timeController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  EventType _selectedType = EventType.sede;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adicionar Novo Evento'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Local'),
              ),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Horário'),
              ),
              ListTile(
                title: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Data: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                trailing: Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Container(
                    child: Text(
                      'Tipo do Evento:',
                      style: TextStyle(fontSize: 16),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButton<EventType>(
                    value: _selectedType,
                    onChanged: (EventType? newType) {
                      setState(() {
                        _selectedType = newType!;
                      });
                    },
                    items: EventType.values.map((EventType type) {
                      return DropdownMenuItem<EventType>(
                        value: type,
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              color: type.eventTypeColor,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(type.eventTypeDetail)
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Adicionar'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final newEvent = Event(
                title: _titleController.text,
                type: EventType.estadual,
                description: _descriptionController.text,
                location: _locationController.text,
                time: _timeController.text,
                date: _selectedDate.toString(),
              );

              widget.onAddEvent(newEvent);
              await EventService().addEvent(newEvent);
              Navigator.of(context).pop(newEvent);
            }
          },
        ),
      ],
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = DateFormat('yyyy-MM-dd')
            .parse(DateFormat('yyyy-MM-dd').format(picked));
      });
    }
  }
}
