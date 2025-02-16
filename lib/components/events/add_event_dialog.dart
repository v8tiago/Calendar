import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/components/model/event.dart';

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
  MaterialColor _selectedColor = Colors.blue;

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
                title: Flexible(
                  child: Text(
                    'Data: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                trailing: Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              ListTile(
                title: Text('Cor do Evento: '),
                trailing: DropdownButton<MaterialColor>(
                  value: _selectedColor,
                  onChanged: (MaterialColor? newColor) {
                    setState(() {
                      _selectedColor = newColor!;
                    });
                  },
                  items: Colors.primaries.map((MaterialColor color) {
                    return DropdownMenuItem<MaterialColor>(
                      value: color,
                      child: Container(
                        width: 24,
                        height: 24,
                        color: color,
                      ),
                    );
                  }).toList(),
                ),
              ),
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
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              //TODO implementar
              // final newEvent = Event(
              //   _titleController.text,
              //   _selectedColor,
              //   _descriptionController.text,
              //   _locationController.text,
              //   _timeController.text,
              //   _selectedDate,
              // );
              // widget.onAddEvent(newEvent);
              Navigator.of(context).pop();
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
        _selectedDate = picked;
      });
    }
  }
}
