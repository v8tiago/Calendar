import 'package:flutter/material.dart';
import 'package:login/components/events/add_event_dialog.dart';
import 'package:login/components/services/event_service.dart';
import 'package:login/pages/login_page.dart';
import 'package:login/pages/profile_page.dart';
import 'package:login/pages/settings_page.dart';

class AppBarHome extends StatefulWidget implements PreferredSizeWidget {
  const AppBarHome({
    super.key,
  });

  @override
  State<AppBarHome> createState() => _AppBarHomeState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarHomeState extends State<AppBarHome> {
  @override
  Widget build(BuildContext context) {
    int currentYear = DateTime.now().year;

    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.menu),
        color: Colors.white, // Ícone de menu (sandwich)
        onPressed: () {
          _showUserMenu(context, currentYear);
        },
      ),
      title: Text(
        "Calendário $currentYear",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 11, 137, 123),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          color: Colors.white,
          onPressed: () {
            _showAddEventDialog(context);
          },
        ),
      ],
    );
  }

  void _showUserMenu(BuildContext context, int currentYear) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Perfil'),
                onTap: () {
                  _profile(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Configurações'),
                onTap: () {
                  _settings(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text('Logout', style: TextStyle(color: Colors.red)),
                onTap: () {
                  _logout(context, currentYear);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddEventDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddEventDialog(onAddEvent: (event) async {
            final response = await EventService().addEvent(event);
            setState(() {});
          });
        });
  }

  void _logout(BuildContext context, int currentYear) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  void _profile(BuildContext context) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => ProfilePage(
          name: 'Tiago Arruda',
          email: 'tiago@gmail.com',
          secretaria: 'Sec. Difusão',
          unidade: 'Belo Horizonte',
          photoUrl: '', // Substitua pelo URL da foto do usuário
        ),
      ),
    )
        .then((_) {
      // Voltar para a tela inicial sem ativar o BottomSheet
      Navigator.of(context).pop();
    });
  }

  void _settings(BuildContext context) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => SettingsPage(),
      ),
    )
        .then((_) {
      // Voltar para a tela inicial sem ativar o BottomSheet
      Navigator.of(context).pop();
    });
  }
}
