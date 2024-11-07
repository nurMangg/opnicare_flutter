import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:opnicare_app/loginPage.dart';
import 'package:opnicare_app/main.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/BoardingScreen/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    var bodyStyle = GoogleFonts.poppins(fontSize: 14.0);

    var pageDecoration = PageDecoration(
      titleTextStyle: GoogleFonts.poppins(fontSize: 24.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 16.0),
      titlePadding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
      pageMargin: const EdgeInsets.only(top: 30.0),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 10000,
      infiniteAutoScroll: true,
      pages: [
        PageViewModel(
          title: "Opnicare System",
          body:
              "Solusi rekam medis elektronik untuk klinik yang lebih cerdas dan cepat.",
          image: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Image.asset(
                'assets/images/opnicare_logo.png',
                height: 40,
                width: 175,
              ),
            ),
            const SizedBox(height: 30),
            _buildImage('onboard1.png'),

          ],
        ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Pengelolaan Data Pasien Mudah",
          body:
              "Akses dan kelola rekam medis kapan saja dengan beberapa klik",
          image: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Image.asset(
                'assets/images/opnicare_logo.png',
                height: 40,
                width: 175,
              ),
            ),
            const SizedBox(height: 30),
            _buildImage('onboard2.png'),
          ],
        ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Integrasi Tanpa Batas",
          body:
              "Terhubung dengan SatuSehat dan sistem lainnya, menjadikan manajemen klinik lebih efisien dan terpadu.",
          image: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Image.asset(
                'assets/images/opnicare_logo.png',
                height: 40,
                width: 175,
              ),
            ),
            const SizedBox(height: 30),
            _buildImage('onboard3.png'),
          ],
        ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back, color: AppColor.secondaryColor,),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600, color: AppColor.secondaryColor)),
      next: const Icon(Icons.arrow_forward, color: AppColor.secondaryColor,),
      done: const Text('Login', style: TextStyle(fontWeight: FontWeight.w600, color: AppColor.secondaryColor)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: AppColor.secondaryColor,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}