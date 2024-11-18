import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opnicare_app/Controller/DatabaseHelper.dart';
import 'package:opnicare_app/Dashboard/DetailContent/DetailMedisContent.dart';
import 'package:opnicare_app/Dashboard/Layanan/Model/ModelMedis.dart';
import 'package:opnicare_app/main.dart';

import 'dart:convert';
import 'package:http/http.dart'
as http;


class MedisContent extends StatefulWidget {
  @override
  _MedisContentState createState() => _MedisContentState();
}

class _MedisContentState extends State<MedisContent> {
  List<Obat> cartItems = [];
  List<Obat> filteredItems = [];
  bool isLoading = true;
  DatabaseHelper databaseHelper = new DatabaseHelper();
  TextEditingController searchController = TextEditingController();

  Future<void> fetchData() async {
    try {
      final List<Obat>? obats = await databaseHelper.getDataObat();
      if (obats != null) {
        setState(() {
          cartItems = obats;
          filteredItems = obats; // Inisialisasi filteredItems dengan data asli
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
    searchController.addListener(_filterList); 
  }

void _filterList() {
  String query = searchController.text.toLowerCase();
  setState(() {
    filteredItems = cartItems.where((item) {
      return item.obatName.toLowerCase().contains(query); // Mengubah item.obatName menjadi lowercase
    }).toList();
  });
}


  @override
  void dispose() {
    searchController.dispose(); // Bersihkan controller ketika widget dihapus
    super.dispose();
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
              'Medis',
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
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
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
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Cari Obat',
                              hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        Uint8List imageBytes;
                        if (item.image != null) {
                          imageBytes = base64Decode(item.image);
                        } else {
                          imageBytes = Uint8List(0);
                        }
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailMedisContent(obat: item),
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
                                  item.image != '' ?
                                  Image.memory(
                                    imageBytes,
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ) :
                                  Image.asset(
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
                                          item.obatName,
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Rp ${item.price}',
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
