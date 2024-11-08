import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:opnicare_app/Dashboard/HomeContent.dart';
import 'package:opnicare_app/Dashboard/JadwalContent.dart';
import 'package:opnicare_app/Dashboard/KeranjangContent.dart';
import 'package:opnicare_app/Dashboard/NotificationContent.dart';
import 'package:opnicare_app/main.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardPage extends StatefulWidget {
  final int selectedIndex;

  DashboardPage({this.selectedIndex = 0});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  Offset _offset = Offset(310, 750);
  DateTime? _lastPressed;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    JadwalContent(),
    KeranjangContent(),
    NotificationContent(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments == 'login') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login berhasil', style: TextStyle(color: Colors.white)),
          backgroundColor: AppColor.primaryColor,
          
        ),
      );
    }
  });
    // Mengatur _selectedIndex dari nilai widget.selectedIndex
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> whatsapp() async {
    String contact = "6285713050749";
    String text = '';
    String androidUrl = "whatsapp://send?phone=$contact&text=$text";
    String iosUrl = "https://wa.me/$contact?text=${Uri.encodeComponent(text)}";
    String webUrl = 'https://api.whatsapp.com/send/?phone=$contact&text=hi';

    try {
      if (Platform.isIOS) {
        if (await canLaunchUrl(Uri.parse(iosUrl))) {
          await launchUrl(Uri.parse(iosUrl));
        }
      } else {
        if (await canLaunchUrl(Uri.parse(androidUrl))) {
          await launchUrl(Uri.parse(androidUrl));
        }
      }
    } catch (e) {
      await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
    }
  }

  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    if (_lastPressed == null || now.difference(_lastPressed!) > Duration(seconds: 2)) {
      _lastPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tekan sekali lagi untuk keluar.'),
          duration: Duration(seconds: 2),
        ),
      );
      return false; // Tidak keluar
    }
    SystemNavigator.pop();
    return true; // Keluar
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        
        return await _onWillPop(); // Menangani aksi kembali
      },
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            // Positioned untuk menempatkan FAB agar bisa digeser
            Positioned(
              left: _offset.dx,
              top: _offset.dy,
              child: Draggable(
                feedback: FloatingActionButton(
                  onPressed: () {},
                  child: Icon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.white,
                  ),
                  backgroundColor: AppColor.secondaryColor,
                ),
                childWhenDragging: Container(),
                child: FloatingActionButton(
                  onPressed: () {
                    whatsapp();
                  },
                  child: Icon(
                    FontAwesomeIcons.whatsapp,
                    color: AppColor.primaryColor,
                  ),
                  backgroundColor: AppColor.secondaryColor,
                ),
                onDragEnd: (details) {
                  setState(() {
                    // Memperbarui posisi FAB sesuai dengan geseran
                    _offset = details.offset;
                  });
                },
              ),
            ),
          ],
        ),
        // BottomNavigationBar untuk navigasi
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Jadwal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Keranjang',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifikasi',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColor.secondaryColor,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          showUnselectedLabels: true,
          iconSize: 28,
          onTap: _onItemTapped,
          elevation: 5,
        ),
        // Padding untuk memberikan space antara FloatingActionButton dan BottomNavigationBar
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomSheet: Padding(
          padding: EdgeInsets.only(bottom: 60),
        ),
      ),
    );
  }
}
