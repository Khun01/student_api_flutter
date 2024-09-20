import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_api/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controllerImage;
  late AnimationController _controllerBg;
  late Animation<double> _scaleAnimationImage;
  late Animation<double> _scaleAnimationBg;

  @override
  void initState() {
    super.initState();
    _controllerImage = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _controllerBg = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimationImage = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(parent: _controllerImage, curve: Curves.easeInOut),
    );

    _scaleAnimationBg = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(parent: _controllerBg, curve: Curves.easeInOut),
    );

    _controllerImage.forward();
    _controllerBg.forward();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 4), () {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomePage()));
    });
  }

  @override
  void dispose() {
    _controllerImage.dispose();
    _controllerBg.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScaleTransition(
          scale: _scaleAnimationBg,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                colors: [
                  Color(0xFFA3D9A5),
                  Color(0xFF6BB577),
                ],
              ),
            ),
            child: ScaleTransition(
              scale: _scaleAnimationImage,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'PHINMA EDUCATION',
                    style: GoogleFonts.abhayaLibre(
                      fontSize: 30,
                      color: const Color(0xFF3B3B3B),
                    ),
                  ),
                  Image.asset('assets/images/phinma_logo.png'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
