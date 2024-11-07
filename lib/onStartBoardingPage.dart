import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opnicare_app/main.dart';
import 'package:opnicare_app/onBoardingPage.dart';

class onStartBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/images/opnicare_logo.png'),
                width: 200
                ), // Top padding
              const SizedBox(height: 70),
              Text(
                'Selamat Datang Di',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Opnicare System',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[700], // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OnBoardingPage()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Mulai',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: AppColor.primaryTextColor,
                    ),
                  ),
                ),
              ),
              const Spacer(), // Pushes the image to the bottom
               Container(
                width: double.maxFinite,
                padding: EdgeInsets.zero,
                child: Image.asset(
                  'assets/images/BoardingScreen/onStart.png', // Path to your image 
                  fit: BoxFit.fill,
                  height: 400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}