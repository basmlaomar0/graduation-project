import 'package:flutter/material.dart';
import 'package:grad_project/screens/add-device.dart';
import 'package:grad_project/screens/failure-page.dart';
import 'package:grad_project/screens/home-page.dart';
import 'package:grad_project/screens/onboarding.dart';
import 'package:grad_project/screens/success-page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
///////////////ModelTest//////////////////
import 'package:flutter/services.dart' show rootBundle;

void testAsset() async {
  try {
    final data = await rootBundle.load('assets/smart_gloves_model.tflite');
    print('✅ Model file size: ${data.lengthInBytes} bytes');
  } catch (e) {
    print('❌ Failed to load asset: $e');
  }
}

////////////////ModelTest//////////////////////////
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // تهيئة Firebase
  testAsset();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MUTE',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
      routes: {
        '/home': (context) => HomePage(),
        '/onboarding': (context) => OnboardingPage(),
        '/success': (context) => SuccessPage(),
        '/failure': (context) => FailurePage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;
  double _scale = 0.8;

  @override
  void initState() {
    super.initState();
    _startAnimation();
    _navigate();
  }

  void _startAnimation() {
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
        _scale = 1.0;
      });
    });
  }

  // دالة لتعيين isFirstTime إلى true أو مسح القيمة المخزنة
  void _resetFirstTimeFlag() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      'isFirstTime',
      true,
    ); ////////// تعيين القيمة إلى true لجعل التطبيق كأنه جديد
  }

  void _navigate() async {
    // إعادة تعيين العلامة لتكون أول مرة
    _resetFirstTimeFlag(); // تعيين isFirstTime إلى true

    await Future.delayed(Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => OnboardingPage()),
      );
    } else {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => AddDevice()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 196, 196, 244),
              Color.fromARGB(255, 226, 226, 245),
              Color.fromARGB(255, 168, 168, 248),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: _opacity,
            child: AnimatedScale(
              duration: Duration(seconds: 1),
              scale: _scale,
              child: CircleAvatar(
                radius: 140,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 140,
                  backgroundImage: AssetImage(
                    'images/WhatsApp Image 2025-04-27 at 3.00.14 PM.jpeg',
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
