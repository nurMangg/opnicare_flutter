import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opnicare_app/Controller/DatabaseHelper.dart';
import 'package:opnicare_app/Dashboard/DetailContent/DetailDokterContent.dart';
import 'package:opnicare_app/Dashboard/DetailContent/DetailMedisContent.dart';
import 'package:opnicare_app/Dashboard/Layanan/Model/ModelDokter.dart';
import 'package:opnicare_app/Dashboard/Layanan/Model/ModelMedis.dart';
import 'package:opnicare_app/main.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;


class DokterContent extends StatefulWidget {
  @override
  _DokterContentState createState() => _DokterContentState();
}

class _DokterContentState extends State < DokterContent > {
// final List<Dokter> cartItems = [
//   Dokter(namaDokter: "Dr. Ayunda Mahesa", tentang: "Lorem Ipsum dolor is amet, lorem lore lore", spesialis: "Dokter Umum", image: "assets/images/Pages/Dokter/Dokter_1.png"),
//   Dokter(namaDokter: "Dr. Ayunda Mahesa", tentang: "Lorem Ipsum dolor is amet, lorem lore lore", spesialis: "Dokter Umum", image: "assets/images/Pages/Dokter/Dokter_1.png"),
//   Dokter(namaDokter: "Dr. Ayunda Mahesa", tentang: "Lorem Ipsum dolor is amet, lorem lore lore", spesialis: "Dokter Umum", image: "assets/images/Pages/Dokter/Dokter_1.png"),
//   Dokter(namaDokter: "Dr. Ayunda Mahesa", tentang: "Lorem Ipsum dolor is amet, lorem lore lore", spesialis: "Dokter Umum", image: "assets/images/Pages/Dokter/Dokter_1.png"),

// ];

List < Dokter > cartItems = [];
bool isLoading = true;
DatabaseHelper databaseHelper = new DatabaseHelper();


String selectedStatus = 'Semua'; 
final List<String> statusOptions = ['Semua', 'Dokter Umum', 'Dokter Anak', 'Dokter Gigi', 'Dokter Mata', 'Dokter Spesialis']; 

Future<void> fetchData() async {
  try {
    final List<Dokter>? dokters = await databaseHelper.getDataDokter();
    if (dokters != null) {
      setState(() {
        cartItems = dokters;
        isLoading = false;
      });
    } else {
      print('Error: Gagal mengambil data');
    }
  } catch (e) {
    print('Error: $e');
  }
}

@override
void initState() {
  super.initState();
  fetchData();
}


@override
Widget build(BuildContext context) {
  return Scaffold( // Tambahkan Scaffold di sini
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
            'Dokter',
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
    body: isLoading
                          ? Center(child: CircularProgressIndicator()) // Tampilkan indikator loading
                          : RefreshIndicator(
      onRefresh: fetchData,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
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
                            hintText: 'Cari Dokter',
                            hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filter Status:',
                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    DropdownButton < String > (
                      dropdownColor: Colors.white,
                      value: selectedStatus,
                      onChanged: (newValue) {
                        setState(() {
                          selectedStatus = newValue!;
                        });
                      },
                      items: statusOptions.map < DropdownMenuItem < String >> ((String value) {
                        return DropdownMenuItem < String > (
                          value: value,
                          child: Text(value, style: GoogleFonts.poppins(fontSize: 14)),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                // List of cart items
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      if (selectedStatus == 'Semua' || item.spesialis == selectedStatus) {
                        Uint8List imageBytes;
                        if (item.image != null) {
                          imageBytes = base64Decode(item.image);
                        } else {
                          // Ganti dengan placeholder image jika null
                          imageBytes = Uint8List(0); // Misal, image kosong atau placeholder
                        }
                        return GestureDetector(
                          onTap: () {
                            // Handle the tap event here
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailDokterContent(item: item),
                              ),
                            );
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
                                      item.image != ''
                                          ? Image.memory(
                                              imageBytes,
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/images/image.png',
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.cover,
                                            ),
                                      const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,

                                            children: [
                                              Text(
                                                item.namaDokter,

                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                                Text(
                                                  item.spesialis,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey[700],
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
                      }
                      return Container();
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