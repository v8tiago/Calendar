import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:login/pages/home/home_page.dart';
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
  ThemeMode _themeMode = ThemeMode.system;

  void _updateTheme(String themeMode) {
    setState(() {
      if (themeMode == 'Claro') {
        _themeMode = ThemeMode.light;
      } else if (themeMode == 'Escuro') {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.system;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Calendario - Acropolitano',
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: [
          Locale('pt', 'BR'),
        ],
        // theme: ThemeData(
        //   useMaterial3: true,
        // ),
        theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
        home: LoginPage(onThemeChanged: _updateTheme),
    );
  }
}
