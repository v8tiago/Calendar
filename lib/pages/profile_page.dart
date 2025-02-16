import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String email;
  final String secretaria;
  final String unidade;
  final String photoUrl;

  const ProfilePage({
    Key? key,
    required this.name,
    required this.email,
    required this.secretaria,
    required this.unidade,
    required this.photoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 11, 137, 123),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(photoUrl),
            ),
            Positioned(
              child: InkWell(
                onTap: () {
                  // Adicione a lógica para carregar uma foto aqui
                },
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.camera_alt,
                    size: 40,
                    color: const Color.fromARGB(255, 11, 137, 123),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              email,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.account_balance),
              title: Text('Secretaria'),
              subtitle: Text(secretaria),
            ),
            ListTile(
              leading: Icon(Icons.location_city),
              title: Text('Unidade'),
              subtitle: Text(unidade),
            ),
          ],
        ),
      ),
    );
  }
}
