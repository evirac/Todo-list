import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? light, ColorScheme? dark) {
      ColorScheme lightScheme;
      ColorScheme darkScheme;

      if (light != null && dark != null) {
        lightScheme = light.harmonized()..copyWith();
        darkScheme = dark.harmonized()..copyWith();
      } else {
        lightScheme = ColorScheme.fromSeed(seedColor: Colors.purple);
        darkScheme = ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.dark,
        );
      }
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, colorScheme: lightScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkScheme),
        title: 'Task Manager',
        home: const HomePage(),
      );
    });
  }
}
