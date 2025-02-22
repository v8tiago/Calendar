import 'package:flutter/material.dart';
import 'package:magic_calendar/core/model/event.dart';
import 'package:magic_calendar/core/model/user.dart';
import 'package:magic_calendar/core/services/event_service.dart';
import 'package:magic_calendar/core/services/user_service.dart';
import 'package:magic_calendar/modules/failLogin/user_not_found_page.dart';
import 'package:magic_calendar/modules/home/home_page.dart';
import 'package:magic_calendar/shared/presentation/widgets/cm_button.dart';
import 'package:magic_calendar/shared/presentation/widgets/cm_text_field.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final userController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn(BuildContext context) async {
    User? user = await UserService().fetchUser(userController.text);
    if (user != null) {
      try {
        Map<String, List<Event>> events =
            await EventService().fetchEvents(DateTime.now().year);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              events: events,
              user: user,
            ),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load events')),
        );
      }
    } else{
     Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserNotFoundPage(
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 0),
              Image.asset(
                'lib/images/NA.jpg',
                height: 120,
              ),
              Text(
                'Bem vindo ao Calendário Mágico!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 50),
              CmTextField(
                controller: userController,
                hintText: 'Email',
                isPassword: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu email';
                  }
                  return null;
                },
              ),
              Text(
                'Esqueceu a senha?',
                style: TextStyle(color: Colors.grey[700]),
              ),
              CmButton(
                onTap: () => signUserIn(context),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Não é um membro?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Entre em contato!',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
