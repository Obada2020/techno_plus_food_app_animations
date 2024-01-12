import 'package:flutter/material.dart';
import 'package:food_app_animations/config/text_theme.dart';
import 'home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  //
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Techno Plus Food App Animations',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        textTheme: globalTextTheme,
      ),
      home: const HomePage(),
    );
  }
}
