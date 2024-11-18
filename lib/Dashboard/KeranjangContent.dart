import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opnicare_app/Component/SuccessDialog.dart';
import 'package:opnicare_app/Controller/DatabaseHelper.dart';
import 'package:opnicare_app/Dashboard/Layanan/Model/ModelKeranjang.dart';
import 'package:opnicare_app/main.dart';

class KeranjangContent extends StatefulWidget {
  @override
  State<KeranjangContent> createState() => _KeranjangContentState();
}

class _KeranjangContentState extends State<KeranjangContent> {
  DatabaseHelper apiService = DatabaseHelper();


  Future<List<Keranjang>> fetchCartItems() async {

    final List<Keranjang>? jsonData = await apiService.getDataKeranjang();
    if (jsonData != null) {
      return jsonData;
    } else {
      return [];
    }
  }

  List<Keranjang> cartItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCartItems().then((value) {
      setState(() {
        cartItems = value;
        isLoading = false;
      });
    });
  }





  @override
  Widget build(BuildContext context) {
    double totalPrice = cartItems.fold(0, (sum, item) => sum + (double.parse(item.price) * double.parse(item.quantity)));

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
              'Keranjang',
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
        child: Column(
          children: [
            // List of cart items
            Expanded(
              child: cartItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Dismissible(
                          key: Key(item.obatName), // Gunakan key unik untuk setiap item
                          direction: DismissDirection.endToStart, // Geser dari kanan ke kiri
                          background: Container(
                            color: Colors.red,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onDismissed: (direction) {
                            // Hapus item dari cartItems
                            setState(() {
                              cartItems.removeAt(index);
                              print(cartItems.length);
                            });
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
                                  item.image != null
                                      ? Image.memory(
                                          base64Decode(item.image),
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: AppColor.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                  Text(
                                    'x${item.quantity}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'Tidak ada item di keranjang',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
            ),

            // Total price section
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Biaya:',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Rp $totalPrice',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.green[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Checkout button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: AppColor.secondaryColor,
              ),
              onPressed: () async {
                // Navigate to payment page

                final response = await apiService.transaksiObat(
                  cartItems.map((item) => {
                    'obatId': item.medicine_id,
                    'jumlah': item.quantity,
                  }).toList(),
                  totalPrice,
                );
                if (response == 200) {
                  SuccessDialog.show(context, message: 'Item Berhasil Ditambahkan Ke Keranjang');
                  fetchCartItems().then((value) {
                    setState(() {
                      cartItems = value;
                      isLoading = false;
                    });
                  });

                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Gagal melakukan transaksi'),
                    ),
                  );
                }
              },
              child: Text(
                'Lanjutkan Pembayaran',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
