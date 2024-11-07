import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opnicare_app/dashboardPage.dart';
import 'package:opnicare_app/loginPage.dart';
import 'package:opnicare_app/main.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
    bool _obscureText = true; 

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText; 
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
                image: AssetImage('assets/images/background_register.png'), // Ganti dengan path gambar Anda
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
                  children: <Widget>[
                    // Gambar ilustrasi di atas form login
                    Image.asset('assets/images/opnicare_logo.png', height: 200),

                    SizedBox(height: 20),

                    // Title "Login"
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'REGISTER',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryTextColor, // Ubah warna teks agar kontras dengan background
                          letterSpacing: 4,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),

                    SizedBox(height: 25),

                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Nama Lengkap',
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Email TextField
                    TextField(
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
                      onPressed: () {
                        // Aksi ketika tombol login ditekan
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardPage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.secondaryColor, // Ganti sesuai kebutuhan
                        minimumSize: Size(120, 50), // Full width button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Register',
                        style: GoogleFonts.poppins(
                          color: AppColor.primaryTextColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Sudah punya akun?',
                          style: TextStyle(
                            color: AppColor.primaryTextColor, // Ubah warna teks agar kontras dengan background
                            fontFamily: 'Poppins',
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                          },
                          child: Text(
                            'Login',
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
