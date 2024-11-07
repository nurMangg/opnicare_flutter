import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opnicare_app/Component/SuccessDialog.dart';
import 'package:opnicare_app/Controller/DatabaseHelper.dart';
import 'package:opnicare_app/Dashboard/Layanan/Model/ModelDokter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailDokterContent extends StatefulWidget {

  final Dokter item;

  const DetailDokterContent({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  _DetailDokterContentState createState() => _DetailDokterContentState();

  
}


class _DetailDokterContentState extends State<DetailDokterContent> {
  final TextEditingController _controllerKeluhan = TextEditingController();
  
  DateTime selectedDate = DateTime.now();


  @override
  Widget build(BuildContext context) {
  
  Uint8List imageBytes = base64Decode(widget.item.image);

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
              'Detail Dokter',
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
      body: Stack(
              children: [
                Positioned(
                  left: -97,
                  top: 70,
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFF007037), Color(0xFFFFD60A)],
                      ),
                      shape: OvalBorder(),
                    ),
                  ),
                ),
                Positioned(
                  left: -51,
                  top: 230,
                  child: Container(
                    width: 254,
                    height: 254,
                    decoration: ShapeDecoration(
                      color: Color(0xFFFFD60A),
                      shape: OvalBorder(),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 40,
                  child: Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/opnicare_logo.png'), // Ensure this path exists
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: -50,
                  top: 150,
                  child: Container(
                    width: 325,
                    height: 325,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(imageBytes), // Ensure this path exists
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 21,
                  top: 450,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    width: 347,
                    height: 191,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.namaDokter,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          widget.item.spesialis,
                          style: GoogleFonts.poppins(
                            color: Color(0xFF848484),
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Lorem Ipsum Dolor is Amet, Lorem Ipsum Dolor is Amet, Lorem Ipsum Dolor is Amet, Lorem Ipsum Dolor is',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                      
                    ),
                    ]
                    ) 

                  ),
                ),

                Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFD60A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Add your action here
                    _showDatePickerModal(context);
                  },
                  child: Text(
                    'Cek Jadwal Dokter',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
              ],
                
            
            ),
      );
          

  }
  void _showDatePickerModal(BuildContext context) {
  DatabaseHelper databaseHelper = new DatabaseHelper();

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
              padding: const EdgeInsets.only(left: 8.0), // Tambahkan padding di sebelah kiri
              child: 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Mengatur agar title rata kiri)
                  children: [
                    Text(
                      'Tanggal Ketersediaan',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Pilih Tanggal Temu Dengan Dokter',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ]
                )
              ),
              SizedBox(height: 16.0),
              // Date Picker langsung tampil di modal
              CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2027),
                onDateChanged: (DateTime value) {
                  setState(() {
                    selectedDate = value; // Simpan tanggal yang dipilih
                  });
                  print('Tanggal yang dipilih: $value');
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                  controller: _controllerKeluhan,
                  decoration: InputDecoration(
                  labelText: 'Keluhan',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFD60A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    final String? no_rm = prefs.getString('no_rm');
                    if (_controllerKeluhan.text.isNotEmpty) {
                      var status = await databaseHelper.sendDateToServer(
                        selectedDate,
                        widget.item.id,
                        no_rm!,
                        _controllerKeluhan.text,
                      );
                      if (status == 200) {
                        SuccessDialog.show(context, message: 'Janji Temu berhasil dibuat');
                      } else {
                        // Handle the error case here
                        print('Failed to create appointment');
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Keluhan harus diisi'),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Pilih Janji Temu',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        )
        );
      },
    );
  }

    
}
