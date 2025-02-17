import 'package:flutter/material.dart';
import 'package:login/components/model/event.dart';
import 'package:login/components/my_button.dart';
import 'package:login/components/my_text_field.dart';
import 'package:login/components/services/event_service.dart';
import 'package:login/components/square_tile.dart';
import 'package:login/pages/home/home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final userController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn(BuildContext context)  async {
    try {
      // Fetch events from the API
      Map<String, List<Event>> events = await EventService().fetchEvents();

      // Navigate to HomePage with the fetched events
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            events: events,
          ),
        ),
      );
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load events')),
      );
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Image.asset(
                'lib/images/NA.jpg',
                height: 120,
              ),
              const SizedBox(height: 30),
              Text(
                'Bem vindo!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 50),
              MyTextField(
                controller: userController,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: passwordController,
                hintText: 'Senha',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              Text(
                'Esqueceu a senha?',
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(height: 25),
              MyButton(
                onTap: () => signUserIn(context),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Ou continue com",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SquareTile(imagePath: 'lib/images/google-logo.png'),
                  SizedBox(width: 25),
                  SquareTile(imagePath: 'lib/images/apple-logo.png'),
                ],
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
      );
  }
}
