import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:magic_calendar/modules/login/presentation/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Calendario - Acropolitano',
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: [
          Locale('pt', 'BR'),
        ],
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: LoginPage(),
    );
  }
}
