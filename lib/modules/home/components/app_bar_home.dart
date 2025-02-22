import 'package:flutter/material.dart';
import 'package:magic_calendar/core/model/user.dart';
import 'package:magic_calendar/modules/home/events/add_event_dialog.dart';
import 'package:magic_calendar/core/services/event_service.dart';
import 'package:magic_calendar/modules/login/presentation/login_page.dart';

class AppBarHome extends StatefulWidget implements PreferredSizeWidget {
  const AppBarHome({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<AppBarHome> createState() => _AppBarHomeState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarHomeState extends State<AppBarHome> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person,
                color: Colors.white), 
          ), 
          SizedBox(width: 10,),
          Text(
            widget.user.name,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 11, 137, 123),
      actions: [
        PopupMenuButton<String>(
          onSelected: (String item) {
            if (item == 'logout') {
              _logout(context);
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'logout',
                child: Text('Sair'),
              ),
            ];
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _logout(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }
}
