import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opnicare_app/onBoardingPage.dart';
import 'package:opnicare_app/onStartBoardingPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Menjalankan animasi setelah 1 detik
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    // Navigasi ke halaman berikutnya setelah 3 detik (misalnya HomePage)
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => onStartBoardingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gambar pada splash screen
            Image.asset(
              'assets/images/logo.png',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20), // Jarak antara gambar dan teks
            // Animasi teks BUMDES PDAM
            AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(seconds: 2), // Durasi animasi fade-in
              child: Text(
                'Opnicare System',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}