import 'package:flutter/material.dart';
import 'package:jisho/screens/home_screen.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jisho/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLogin = false;

    SharedPreferences.getInstance().then((pref) async {
      final username = pref.getString('username');
      isLogin = username != null;
    });

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red.shade800),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: FlutterSplashScreen.fadeIn(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.red.shade400,
            Colors.red.shade800,
          ],
        ),
        childWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/9/9e/Flag_of_Japan.svg",
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "辞書",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontFamily: GoogleFonts.shipporiAntique().fontFamily,
              ),
            ),
            const Text(
              "Japanese Dictionary",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            )
          ],
        ),
        duration: const Duration(milliseconds: 2000),
        animationDuration: const Duration(milliseconds: 1000),
        nextScreen: isLogin ? const HomeScreen() : const LoginScreen(),
      ),
    );
  }
}
