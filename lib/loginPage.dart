import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opnicare_app/Controller/DatabaseHelper.dart';
import 'package:opnicare_app/dashboardPage.dart';
import 'package:opnicare_app/main.dart';
import 'package:opnicare_app/registerPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key
  });

  @override
  State < LoginPage > createState() => _LoginPageState();
}

class _LoginPageState extends State < LoginPage > {

  // read() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final key = 'token';
  //   final value = prefs.get(key ) ?? 0;
  //   print(value);
  //   if(value != '0'){
  //     Navigator.of(context).push(
  //         new MaterialPageRoute(
  //           builder: (BuildContext context) => new DashboardPage(),
  //         )
  //     );
  //   }
  // }

  @override
  initState(){
    super.initState();
    // read();
    databaseHelper.getCsrfToken();
  }

  DatabaseHelper databaseHelper = new DatabaseHelper();
  String msgStatus = '';

  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  bool isLoading = false;


  _onPressed() {
    // await databaseHelper.getCsrfToken();

    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      setState(() {
        isLoading = true; // Set status loading ke true
      });

      // Memanggil fungsi login dan menangani respons
      databaseHelper.loginData(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      ).then((success) {
        setState(() {
          isLoading = false; // Set status loading ke false setelah login selesai
        });
        
        if (success) {
          print("Login berhasil");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => DashboardPage()),
          );
        } else {
          print("Login salah");
          _showDialog();
          setState(() {
            msgStatus = 'Check email or password';
          });
        }
      });
    }
  }

  bool _obscureText = true; // Untuk menyimpan status apakah password tersembunyi atau tidak

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText; // Mengubah status obscureText
    });
  }

  void _launchWhatsApp() async {
    final url = 'https://api.whatsapp.com/send?phone=6285713050749&text=Halo%2C%20Saya%20mau%20reset%20password%20aplikasi%20PDAM%20BUMDES!.';

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gambar latar belakang
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'), // Ganti dengan path gambar Anda
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Konten di atas gambar latar belakang
          Padding(
            padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: < Widget > [
                      // Gambar ilustrasi di atas form login
                      Image.asset('assets/images/opnicare_logo.png', height: 200),

                      SizedBox(height: 20),

                      // Title "Login"
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'LOGIN',
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryTextColor, // Ubah warna teks agar kontras dengan background
                            letterSpacing: 4,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),

                      SizedBox(height: 25),

                      // Email TextField
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      // Password TextField
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            iconSize: 20,
                            icon: Icon(
                              _obscureText ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      // Login Button
                      ElevatedButton(
                      onPressed: isLoading ? null : _onPressed, // Nonaktifkan tombol saat loading
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.secondaryColor, // Ganti sesuai kebutuhan
                        minimumSize: Size(120, 50), // Full width button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: isLoading
                          ? CircularProgressIndicator(color: AppColor.primaryTextColor) // Tampilkan indikator loading
                          : Text(
                              'Login',
                              style: GoogleFonts.poppins(
                                color: AppColor.primaryTextColor,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                    ),

                      SizedBox(height: 20),
                      Text(
                        '$msgStatus',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: < Widget > [
                                Text(
                                  'Lupa Password?',
                                  style: TextStyle(
                                    color: AppColor.primaryTextColor, // Ubah warna teks agar kontras dengan background
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _launchWhatsApp();
                                  },
                                  child: Text(
                                    'Hubungi Tim',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: const Color.fromARGB(255, 0, 152, 218),
                                        fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: < Widget > [
                                Text(
                                  'Belum Punya Akun?',
                                  style: TextStyle(
                                    color: AppColor.primaryTextColor, // Ubah warna teks agar kontras dengan background
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => RegisterPage(),
                                    ));
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: const Color.fromARGB(255, 0, 152, 218),
                                        fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ), )
                    ],
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('Failed'),
          content: new Text('Check your email or password'),
          actions: < Widget > [
            new MaterialButton(

              child: new Text(
                'Close',
              ),

              onPressed: () {
                Navigator.of(context).pop();
              },

            ),
          ],
        );
      }
    );
  }
}