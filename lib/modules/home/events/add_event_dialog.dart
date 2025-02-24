import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magic_calendar/core/model/event.dart';
import 'package:magic_calendar/core/model/event_type.dart';
import 'package:magic_calendar/core/services/dto/event_request.dart';
import 'package:magic_calendar/core/services/event_service.dart';

class AddEventDialog extends StatefulWidget {
  final Function(Event) onAddEvent;

  const AddEventDialog({required this.onAddEvent, super.key});

  @override
  AddEventDialogState createState() => AddEventDialogState();
}

class AddEventDialogState extends State<AddEventDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  bool _isAllDay = false;
  DateTime _selectedDate = DateTime.now();
  EventType _selectedType = EventType.sede;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Adicionar Evento')),
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
              CheckboxListTile(
                title: Text('Dia inteiro'),
                value: _isAllDay,
                onChanged: (bool? value) {
                  setState(() {
                    _isAllDay = value ?? false;
                    if (_isAllDay) {
                      _startTimeController.clear();
                      _endTimeController.clear();
                    }
                  });
                },
              ),
              TextFormField(
                controller: _startTimeController,
                decoration: InputDecoration(labelText: 'Início'),
                readOnly: true,
                enabled: !_isAllDay,
                onTap: () async {
                  if (!_isAllDay) {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        _startTimeController.text = pickedTime.format(context);
                      });
                    }
                  }
                },
              ),
              TextFormField(
                controller: _endTimeController,
                decoration: InputDecoration(labelText: 'Fim'),
                readOnly: true,
                enabled: !_isAllDay,
                onTap: () async {
                  if (!_isAllDay) {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        _endTimeController.text = pickedTime.format(context);
                      });
                    }
                  }
                },
              ),
              ListTile(
                title: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Data: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
                trailing: Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Tipo:',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    width: 20,
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
              final newEvent = EventRequest(
                title: _titleController.text,
                type: _selectedType.name.toString().toUpperCase(),
                description: _descriptionController.text,
                location: _locationController.text,
                isAllDay: _isAllDay,
                startTime:
                    _parseString(_startTimeController.text, _isAllDay),
                endTime: _parseString(_endTimeController.text, _isAllDay),
                date: DateFormat('yyyy-MM-dd').format(_selectedDate),
              );

              Event eventCreated = await EventService().addEvent(newEvent);
              widget.onAddEvent(eventCreated);
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

    String _parseString(String time, bool isAllDay) {
    if (!isAllDay) {
      return time;
    }
    return '00:00';
  }
}
