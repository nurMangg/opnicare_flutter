import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opnicare_app/Controller/DatabaseHelper.dart';
import 'package:opnicare_app/main.dart';

class ProfileContent extends StatefulWidget {
  @override
  _ProfileContentState createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  Map<String, dynamic>? userData; // Untuk menyimpan data pengguna
  bool isLoading = true; // Untuk menampilkan indikator loading
  final DatabaseHelper apiService = DatabaseHelper(); // Instance ApiService

  @override
  void initState() {
    super.initState();
    getDataUser (); // Panggil fungsi untuk mendapatkan data pengguna
  }

  Future<void> getDataUser () async {
    userData = await apiService.getDataUser (); // Ambil data pengguna
    setState(() {
      isLoading = false; // Set loading ke false setelah mendapatkan data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Informasi Pasien',
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
          : Column(
              children: [
                // Header Profil dengan warna biru
                Container(
                  padding: EdgeInsets.fromLTRB(18.0, 50.0, 18.0, 30.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      transform: GradientRotation(270),
                      colors: [
                        Color(0xFF007037),
                        Color(0xFFFFD60A),
                      ],
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/Pages/rohman.png'), // Ganti dengan gambar profil pasien
                      ),
                      SizedBox(height: 16),
                      Text(
                        userData?['nama_pasien'] ?? 'Nama Pengguna', // Ganti dengan data nama pengguna
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        userData?['email'] ?? 'Email Pengguna', // Ganti dengan data email pengguna
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                // Konten Informasi Pasien
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(18.0),
                    children: [
                      // Informasi Nomor Rekam Medis
                      ListTile(
                        leading: Icon(Icons.assignment, color: AppColor.primaryColor),
                        title: Text('Nomor Rekam Medis'),
                        subtitle: Text(userData?['no_rm'] ?? 'RM123456'), // Ganti dengan data nomor rekam medis
                      ),
                      Divider(),

                      // Informasi Tanggal Lahir
                      ListTile(
                        leading: Icon(Icons.calendar_today, color: AppColor.primaryColor),
                        title: Text('Tanggal Lahir'),
                        subtitle: Text(userData?['tanggal_lahir'] ?? '01 Januari 1990'), // Ganti dengan data tanggal lahir
                      ),
                      Divider(),

                      ListTile(
                        leading: Icon(Icons.person, color: AppColor.primaryColor),
                        title: Text('Jenis Kelamin'),
                        subtitle: Text(userData?['jk'] ?? 'Tidak disetel'), // Ganti dengan data jenis kelamin
                      ),
                      Divider(),
                      
                      // Informasi Nomor Telepon
                      ListTile(
                        leading: Icon(Icons.phone, color: AppColor.primaryColor),
                        title: Text('Nomor Telepon'),
                        subtitle: Text(userData?['phone'] ?? '+62 857 1305 0749'), // Ganti dengan data nomor telepon
                      ),
                      Divider(),
                      
                      // Informasi Alamat
                      ListTile(
                        leading: Icon(Icons.home, color: AppColor.primaryColor),
                        title: Text('Alamat'),
                        subtitle: Text(userData?['alamat'] ?? 'Desa Pesarean, RT.05 RW.04'), // Ganti dengan data alamat
                      ),
                      Divider(),
                      
                      // Tombol Edit Profil
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfileContent()));
                          },
                          icon: Icon(Icons.edit),
                          label: Text('Edit Profil'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppColor.primaryColor,
                            backgroundColor: AppColor.secondaryColor,
                            padding: EdgeInsets.symmetric(vertical: 14.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      
                      // Tombol Logout
                
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}