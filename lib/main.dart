import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const FindItApp(),
    ),
  );
}

class FindItApp extends StatelessWidget {
  const FindItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FindIt',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C4EFF),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}