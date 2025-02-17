import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _themeMode = 'Sistema';

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Escolha o Tema'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  _themeMode = 'Claro';
                });
                // widget.onThemeChanged('Claro')
                Navigator.pop(context);
              },
              child: Text('Claro'),
            ),
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  _themeMode = 'Escuro';
                });
                // widget.onThemeChanged('Escuro');
                Navigator.pop(context);
              },
              child: Text('Escuro'),
            ),
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  _themeMode = 'Sistema';
                });
                // widget.onThemeChanged('Sistema');
                Navigator.pop(context);
              },
              child: Text('Seguindo o Padrão do Sistema'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configurações',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 11, 137, 123),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Configurações do Calendário'),
              onTap: () {
                // Adicione a lógica para configurar o calendário aqui
              },
            ),
            ListTile(
              leading: Icon(Icons.brightness_6),
              title: Text('Tema'),
              trailing: Text(_themeMode),
              onTap: _showThemeDialog,
            ),
          ],
        ),
      ),
    );
  }
}