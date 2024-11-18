import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opnicare_app/Component/SuccessDialog.dart';
import 'package:opnicare_app/Component/SuccessDialogPop.dart';
import 'package:opnicare_app/Controller/DatabaseHelper.dart';
import 'package:opnicare_app/Dashboard/Layanan/Model/ModelMedis.dart';

class DetailMedisContent extends StatefulWidget {
  final Obat obat;

  DetailMedisContent({
    required this.obat
  });

  @override
  _DetailMedisContentState createState() => _DetailMedisContentState();
}

class _DetailMedisContentState extends State < DetailMedisContent > {
  bool isLoading = false;

  int _quantity = 1;
  DatabaseHelper databaseHelper = new DatabaseHelper();

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Uint8List imageBytes;
    if (widget.obat.image != null) {
      imageBytes = base64Decode(widget.obat.image);
    } else {
      // Ganti dengan placeholder image jika null
      imageBytes = Uint8List(0); // Misal, image kosong atau placeholder
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // Tinggi AppBar
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF007037), Color(0xFFFFD60A)], // Gradient AppBar
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: AppBar(
            title: Text(
              'Detail Medis',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          :Padding(
        padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    widget.obat.image != '' ?
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.obat.obatName,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${widget.obat.price}",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Spacer(), // Spacer to push buttons to the bottom
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      // Aksi menambahkan ke keranjang
                      var result = await databaseHelper.tambahKeranjang(widget.obat.obatId, _quantity);
                      setState(() {
                        isLoading = false;
                      });
                      if (result == 200) {
                        SuccessDialogPop.show(context, message: 'Item Berhasil Ditambahkan Ke Keranjang');
                      } else {
                        SuccessDialogPop.show(context, message: 'Item Gagal Ditambahkan Ke Keranjang');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFD60A),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    ),
                    child: Text(
                      'Tambah ke Keranjang',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: _decrementQuantity,
                      ),
                      Text(
                        '$_quantity',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: _incrementQuantity,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
      ),
    );
  }
}