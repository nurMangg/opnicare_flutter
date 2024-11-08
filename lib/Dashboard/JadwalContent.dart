import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opnicare_app/Controller/DatabaseHelper.dart';
import 'package:opnicare_app/Dashboard/DetailContent/DetailJadwalContent.dart';
import 'package:opnicare_app/Dashboard/Layanan/Model/ModelRiwayatPendaftaran.dart';

class JadwalContent extends StatefulWidget {
  @override
  _JadwalContentState createState() => _JadwalContentState();
}

class _JadwalContentState extends State<JadwalContent> {
  List<RiwayatPendaftaran>? riwayatPendaftaran;
  bool isLoading = true;
  String selectedStatus = 'Semua';
  final List<String> statusOptions = ['Semua', 'Dalam Antrian', 'Terdaftar'];

  @override
  void initState() {
    super.initState();
    fetchRiwayat();
  }

  Future<void> fetchRiwayat() async {
    DatabaseHelper apiService = DatabaseHelper();
    List<RiwayatPendaftaran>? data = await apiService.getRiwayatPendaftaran();
    setState(() {
      riwayatPendaftaran = data;
      isLoading = false;
    });
  }

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
              'Riwayat Jadwal Janji Temu',
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filter Status:',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      DropdownButton<String>(
                        value: selectedStatus,
                        onChanged: (newValue) {
                          setState(() {
                            selectedStatus = newValue!;
                          });
                        },
                        items: statusOptions
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: riwayatPendaftaran?.length ?? 0,
                      itemBuilder: (context, index) {
                        final appointment = riwayatPendaftaran![index];
                        if (selectedStatus == 'Semua' ||
                            appointment.status == selectedStatus) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailJanjiTemu(riwayatPendaftaran: appointment)),
                              );
                            },
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 3,
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${appointment.dokterId}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 1),
                                    Text(
                                      '${appointment.poliId}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_today,
                                            color: Colors.grey[600], size: 16),
                                        SizedBox(width: 6),
                                        Text(
                                          appointment.tanggalDaftar,
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(Icons.info_outline,
                                            color: Colors.grey[600], size: 16),
                                        SizedBox(width: 6),
                                        Text(
                                          'Status: ${appointment.status}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: appointment.status == 'Terdaftar'
                                                ? Colors.blue
                                                : appointment.status == 'Dalam Antrian'
                                                    ? Colors.orange
                                                    : appointment.status == 'Selesai'
                                                    ? Colors.green : Colors.red,
                                          ),
                                        ),
                                      ],
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
    );
  }
}
