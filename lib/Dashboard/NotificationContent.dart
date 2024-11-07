import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opnicare_app/main.dart';

class NotificationContent extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationContent> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        'title': 'Pendaftaran Berhasil',
        'date': '20 Oktober 2024',
        'message': 'Pendaftaran Anda untuk pemeriksaan kesehatan telah berhasil. Silakan cek jadwal Anda.',
      },
      {
        'title': 'Jadwal Konsultasi',
        'date': '19 Oktober 2024',
        'message': 'Anda memiliki jadwal konsultasi dengan dokter pada 22 Oktober 2024 pukul 10:00.',
      },
      {
        'title': 'Hasil Pemeriksaan Tersedia',
        'date': '18 Oktober 2024',
        'message': 'Hasil pemeriksaan kesehatan Anda telah tersedia. Silakan periksa di aplikasi.',
      },
      {
        'title': 'Pembaruan Sistem',
        'date': '10 Oktober 2024',
        'message': 'Kami telah memperbarui sistem OPNICARE untuk meningkatkan pengalaman pengguna. Cek fitur baru sekarang!',
      },
    ];


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
              'Notifikasi',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0, 
            foregroundColor: Colors.white,
          ),
        ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];

            return Card(
              color: AppColor.secondaryTextColor,
              margin: EdgeInsets.only(bottom: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          notification['title']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor,
                          ),
                        ),
                        const Icon(
                        Icons.notifications_active_rounded,
                        size: 20.0,
                        color: Color.fromARGB(255, 81, 81, 81),
                        ),
                      ]
                    ),
                    SizedBox(height: 8),
                    Text(
                      notification['date']!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      notification['message']!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}