import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LaporanContent extends StatelessWidget {
  final List<Map<String, String>> rekamMedis = [
    {
      'tanggal': '20 Oktober 2024',
      'diagnosa': 'Demam Berdarah',
      'dokter': 'Dr. Ayunda Mahesa',
      'catatan': 'Pasien harus istirahat total dan melakukan pengecekan darah secara berkala.'
    },
    {
      'tanggal': '15 Agustus 2024',
      'diagnosa': 'Tifus',
      'dokter': 'Dr. Budi Santoso',
      'catatan': 'Pasien perlu istirahat selama 2 minggu dan menjaga pola makan.'
    },
    // Tambahkan data rekam medis lain di sini
  ];

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
              'Laporan',
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
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: rekamMedis.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              elevation: 3,
              margin: EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tanggal: ${rekamMedis[index]['tanggal']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Diagnosa: ${rekamMedis[index]['diagnosa']}'),
                    SizedBox(height: 8),
                    Text('Dokter: ${rekamMedis[index]['dokter']}'),
                    SizedBox(height: 8),
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