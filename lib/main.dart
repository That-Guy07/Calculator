import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:calculator/screens/home.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 255, 255, 255),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);
final themeDark = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 255, 255, 255),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      darkTheme: themeDark,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
