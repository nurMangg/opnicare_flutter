import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opnicare_app/Dashboard/Layanan/Model/ModelKamar.dart';
import 'package:opnicare_app/main.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:typed_data';


class KamarContent extends StatefulWidget {
  @override
  _KamarContentState createState() => _KamarContentState();
}

class _KamarContentState extends State < KamarContent > {
  List<Kamar> kamarList = [];
  bool isLoading = true;

  Future<void> fetchData() async {
    try {
      final baseUrl = Url.base_url ;
      final response = await http.get(Uri.parse('${baseUrl}masters/kamars/api/getKamar'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final Kamars = List<Kamar>.from(jsonData.map((json) => Kamar.fromJson(json)));
        setState(() {
          kamarList = Kamars;
          isLoading = false;

        });
      } else {
        print('Error: Gagal mengambil data');
      }
    } catch (e) {
      print('Error: $e');
    }
    return; 
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

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
              'Ketersediaan Kamar',
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
      body: RefreshIndicator(
      onRefresh: fetchData,
      child: isLoading
          ? Center(child: CircularProgressIndicator()) // Tampilkan indikator loading
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar (optional)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.yellow[100],
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
                        hintText: 'Cari Kamar',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // List of rooms
            Expanded(
              child: ListView.builder(
                itemCount: kamarList.length,
                itemBuilder: (context, index) {
                  final item = kamarList[index];
                  return GestureDetector(
                    onTap: () {
                      // Handle the tap event here
                    },
                    child: Card(
                      color: AppColor.secondaryTextColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                          
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.namaKamar,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Nomor Kamar: ${item.nomorKamar}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Fasilitas: ${item.fasilitas}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Status: ${item.status}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: item.status == 'tersedia'
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
    );
      }
}