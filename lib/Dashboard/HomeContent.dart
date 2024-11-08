import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opnicare_app/Dashboard/DetailContent/DetailDokterContent.dart';
import 'package:opnicare_app/Dashboard/Layanan/KontakContent.dart';
import 'package:opnicare_app/Dashboard/Layanan/LaporanContent.dart';
import 'package:opnicare_app/Dashboard/Layanan/DokterContent.dart';
import 'package:opnicare_app/Dashboard/Layanan/KamarContent.dart';
import 'package:opnicare_app/Dashboard/Layanan/KritikSaranContent.dart';
import 'package:opnicare_app/Dashboard/Layanan/MedisContent.dart';
import 'package:opnicare_app/Dashboard/Layanan/PengaturanContent.dart';
import 'package:opnicare_app/Dashboard/Layanan/ProfileContent.dart';
import 'package:opnicare_app/main.dart';

class HomeContent extends StatefulWidget {
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  
  final List<String> newsList = [
    'Berita 1: Update terbaru dari OPNICARE...',
    'Berita 2: Peluncuran fitur baru...',
    'Berita 3: OPNICARE mendukung klinik di seluruh negeri...',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              
              // Greeting Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '👋 Halo!,',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Nur Rohman',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/images/Pages/rohman.png'), // Replace with your image path
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Search Bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.yellow[100], // Light yellow background
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Cari apa disini...',
                          hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dapatkan Pelayanan\nMedical Terbaik',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                              style: GoogleFonts.poppins(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      child: Image.asset(
                        'assets/images/Pages/banner_dashboard.png', // Replace with your image path
                        height: 160,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),


              // Layanan Section
              Text(
                'Layanan',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ServiceIcon(
                    icon: Icons.person,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfileContent(),
                        ),
                      );
                    },
                    label: 'Pasien',
                  ),
                  ServiceIcon(
                    icon: Icons.medical_services,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MedisContent(),
                        ),
                      );
                    },
                    label: 'Medis',
                  ),
                  ServiceIcon(
                    icon: Icons.bed,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => KamarContent(),
                        ),
                      );
                    },
                    label: 'Kamar',
                  ),
                  ServiceIcon(
                    icon: Icons.contact_emergency,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => KontakContent(),
                        ),
                      );
                    },
                    label: 'Kontak',
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ServiceIcon(
                    icon: Icons.person_search,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DokterContent(),
                        ),
                      );
                    },
                    label: 'Dokter',
                  ),
                  ServiceIcon(
                    icon: Icons.chat_bubble,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => KritikSaranContent(),
                        ),
                      );
                    },
                    label: 'Kritik & Saran',
                  ),
                  ServiceIcon(
                    icon: Icons.receipt_long,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LaporanContent(),
                        ),
                      );
                    },
                    label: 'Laporan',
                  ),
                  ServiceIcon(
                    icon: Icons.settings,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PengaturanContent(),
                        ),
                      );
                    },
                    label: 'Pengaturan',
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Banner Section
              
              const SizedBox(height: 20),

              // Berita Terkini Section
              Text(
                'Berita Terkini',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              CarouselSlider(
                options: CarouselOptions(
                  height: 150.0, // Set the height of the slider
                  enableInfiniteScroll: false, // Disable infinite scrolling (no looping)
                  autoPlay: false, // Disable auto-play
                  enlargeCenterPage: true, // Enlarge the current item
                  viewportFraction: 1, 
                ),
                items: newsList.map((news) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          // Tambahkan aksi yang ingin dilakukan saat item ditekan
                          print('Tapped on: $news');
                          // Misalnya, navigasi ke halaman detail atau melakukan tindakan lain
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width, // Full width of the container
                          margin: EdgeInsets.symmetric(horizontal: 3.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/Pages/Berita/berita.png'), 
                              fit: BoxFit.cover, 
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      );
                      
                    },
                  );
                }).toList(),

              ),
              const SizedBox(height: 40),

            ],
          ),
        ),
      ),
    );
  }
}

class ServiceIcon extends StatelessWidget {
  final IconData icon;
  final String label; // Add label for the text below the icon
  final VoidCallback onPressed; // Add onPressed callback

  const ServiceIcon({
    required this.icon,
    required this.label, // Make label a required parameter
    required this.onPressed, // Make onPressed a required parameter
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Ensures the column takes minimal space
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.secondaryColor, // Background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16), // Rounded corners
            ),
            padding: const EdgeInsets.all(0), // Remove padding for icon
          ),
          onPressed: onPressed, // Handle button press
          child: SizedBox(
            height: 60,
            width: 60,
            child: Icon(
              icon,
              size: 32,
              color: AppColor.primaryColor, // Icon color
            ),
          ),
        ),
        const SizedBox(height: 6), // Spacing between icon and text
        Text(
          label, // Display the label below the icon
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

