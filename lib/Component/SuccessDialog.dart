import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:opnicare_app/Dashboard/HomeContent.dart';
import 'package:opnicare_app/dashboardPage.dart';

class SuccessDialog {
  static void show(BuildContext context, {String message = 'Success'}) {
    showDialog(
      
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/success.json', // Pastikan path animasi benar
                  width: 150,
                  height: 150,
                  repeat: false, // Animasi hanya berjalan sekali
                ),
                SizedBox(height: 16.0),
                Text(
                  message, // Pesan yang dapat disesuaikan
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardPage()), 
                    (Route<dynamic> route) => false, // Ini memastikan semua halaman sebelumnya dihapus
                  );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFD60A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'OK',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
