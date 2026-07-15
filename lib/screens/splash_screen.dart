import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    goToNextScreen();
  }

  Future<void> goToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6C4EFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.search_rounded,
                size: 60,
                color: Color(0xFF6C4EFF),
              ),
            ),

            const SizedBox(height: 24),

            // App Name
            const Text(
              'FindIt',
              style: TextStyle(
                color: Colors.white,
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // Tagline
            const Text(
              'Lost. Found. Reconnected.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 50),

            // Loading Indicator
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}