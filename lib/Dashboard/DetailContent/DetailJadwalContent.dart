import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opnicare_app/Dashboard/Layanan/Model/ModelRiwayatPendaftaran.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetailJanjiTemu extends StatefulWidget {

  RiwayatPendaftaran? riwayatPendaftaran;


  DetailJanjiTemu({required this.riwayatPendaftaran});

  @override
  State<DetailJanjiTemu> createState() => _DetailJanjiTemuState();
}

class _DetailJanjiTemuState extends State<DetailJanjiTemu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 0, // Mengatur posisi dari atas
            left: 0,
            right: 0,
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.yellow],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Riwayat Janji Temu',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text(
                      'Ini adalah detail riwayat dari janji temu anda dengan dokter',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 183, // Mengatur posisi dari atas
            left: 0,
            right: 0,
            bottom: 0, // Mengatur posisi dari bawah
            child: Container(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        widget.riwayatPendaftaran!.updatedAt,
                        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: Container(
                        width: 250.0,
                        height: 250.0,
                        color: Colors.white,
                        child: QrImageView(
                          data: "${widget.riwayatPendaftaran!.noPendaftaran}",
                          version: QrVersions.auto,
                          size: 250.0,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          errorStateBuilder: (context, error) => Center(
                            child: Text(
                              'QR Error',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildDetailItem("No. Pendaftaran", "${widget.riwayatPendaftaran!.noPendaftaran}"),
                    Divider(),

                    SizedBox(height: 10),
                    _buildDetailItem("Nama Dokter", "${widget.riwayatPendaftaran!.dokterId}"),
                    Divider(),

                    SizedBox(height: 10),
                    _buildDetailItem("Nomor Ruang", "${widget.riwayatPendaftaran!.poliId}"),
                    Divider(),
                    
                    SizedBox(height: 10),
                    _buildDetailItem("Tanggal Pendaftaran", "${widget.riwayatPendaftaran!.tanggalDaftar}"),
                    Divider(),

                    SizedBox(height: 10),
                    _buildDetailItem("Est. Masuk", "09:00 AM"),
                    Divider(),

                    SizedBox(height: 10),
                    _buildDetailItem("Status", "${widget.riwayatPendaftaran!.status}"),
                    Divider(),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}