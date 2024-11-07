import 'package:flutter/material.dart';
import 'package:opnicare_app/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Opnicare App',
      
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.secondaryColor),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

class AppColor {
  static const Color primaryColor = Color(0xFF007037);
  static const Color secondaryColor = Color(0xFFffd60a);
  static const Color primaryTextColor = Color(0xFF000000);
  static const Color secondaryTextColor = Color(0xFFFFFFFF);
}

class Url {
  static const String base_url = 'http://192.168.1.62:8000/';
}
