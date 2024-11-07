import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KontakContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF007037),
                Color(0xFFFFD60A),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: AppBar(
            title: Text(
              'Kontak',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/opnicare_logo.png'), width: 300),
            SizedBox(height: 16),
            Text(
              "Klinik Opnicare",
              style: GoogleFonts.poppins(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Pedurungan, Semarang Selatan",
                    style: GoogleFonts.poppins(fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  "+62 857 1305 0749",
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.email, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  "info@opnicare.com",
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }


}
