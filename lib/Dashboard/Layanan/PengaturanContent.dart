import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opnicare_app/Controller/DatabaseHelper.dart';
import 'package:opnicare_app/loginPage.dart';
import 'package:opnicare_app/main.dart';


class PengaturanContent extends StatelessWidget {
  DatabaseHelper databaseHelper = new DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // Tinggi AppBar
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
              'Pengaturan',
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
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.account_circle, color: AppColor.primaryColor),
            title: Text('Pengaturan Bahasa'),
            onTap: () {
              // Navigasi ke halaman pengaturan profil pengguna

            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications, color: AppColor.primaryColor),
            title: Text('Notifikasi'),
            onTap: () {
              // Navigasi ke halaman pengaturan notifikasi

            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help, color: AppColor.primaryColor),
            title: Text('Panduan Penggunaan'),
            onTap: () {
              // Navigasi ke halaman pengaturan privasi

            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.privacy_tip, color: AppColor.primaryColor),
            title: Text('Privasi'),
            onTap: () {
              // Navigasi ke halaman pengaturan privasi

            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help, color: AppColor.primaryColor),
            title: Text('Pusat Bantuan'),
            onTap: () {
              // Log out atau navigasi kembali ke halaman login
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info, color: AppColor.primaryColor),
            title: Text('Tentang Aplikasi'),
            onTap: () {
              // Log out atau navigasi kembali ke halaman login
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: AppColor.primaryColor),
            title: Text('Keluar'),
            onTap: () async {
              await databaseHelper.logout();
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                  settings: RouteSettings(arguments: 'logout'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
