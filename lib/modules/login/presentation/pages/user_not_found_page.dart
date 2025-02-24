import 'package:flutter/material.dart';
import 'package:magic_calendar/modules/login/presentation/pages/login_page.dart';

class UserNotFoundPage extends StatelessWidget {
  const UserNotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Algo deu errado!', style: TextStyle(color: Colors.white),),
        automaticallyImplyLeading: false, 
        backgroundColor: Color.fromARGB(255, 11, 137, 123),
      ),
      body: 
      Container(
        color: Color.fromARGB(255, 11, 137, 123),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Desculpe não foi possível encontrar esse usuário. Verifique seu email ou entre em contato com a sede.',
                style: TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
                
              ),
              SizedBox(height: 60),
              SizedBox(height: 80),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('Voltar para Login', style: TextStyle(color: Colors.black),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}