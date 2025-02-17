import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:login/pages/login_page.dart';

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
      //   theme: ThemeData.light(),
      // darkTheme: ThemeData.dark(),
        home: LoginPage(),
    );
  }
}
