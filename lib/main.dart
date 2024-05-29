import 'package:flutter/material.dart';
import 'package:mondaechat/screens/onboarding/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MONDAEAI',
      theme: ThemeData(
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
              fontSize: 16.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.normal),
          displayLarge: TextStyle(
              fontSize: 24.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
          displayMedium: TextStyle(
              fontSize: 22.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
          // Tambahkan gaya teks lainnya sesuai kebutuhan
        ),
        primarySwatch: Colors.blue,
      ),
      home: const OnboardingScreen(),
    );
  }
}
