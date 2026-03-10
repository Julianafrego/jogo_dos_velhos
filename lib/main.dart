import 'package:flutter/material.dart';
import 'view/screens/jogoscreen.dart';

void main() {
  runApp(const JogoDaVelhaApp());
}

class JogoDaVelhaApp extends StatefulWidget {
  const JogoDaVelhaApp({super.key});

  @override
  State<JogoDaVelhaApp> createState() => _JogoDaVelhaAppState();
}

class _JogoDaVelhaAppState extends State<JogoDaVelhaApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void alternarTema() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color verdePrincipal = Color(0xFF7BC47F);
    const Color verdeEscuro = Color(0xFF4F9D69);
    const Color begeClaro = Color(0xFFF5E6D3);

    return MaterialApp(
      title: 'Jogo da Velha',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: verdePrincipal,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: verdePrincipal,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: verdeEscuro,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: begeClaro,
          foregroundColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: verdePrincipal,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: verdeEscuro,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF2C2C2C),
          foregroundColor: Colors.white,
        ),
      ),
      home: JogoScreen(
        onAlternarTema: alternarTema,
        temaEscuro: _themeMode == ThemeMode.dark,
      ),
    );
  }
}