import 'package:flutter/material.dart';
import 'package:grad_project/screens/account.dart';
import 'package:grad_project/screens/glove-settings.dart';
import 'package:grad_project/screens/help-page.dart';
import 'package:grad_project/screens/history_page.dart';
import 'package:grad_project/screens/home-page.dart';
import 'package:grad_project/screens/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  String? _activeButton; // اسم الزر المضغوط مؤقتًا
String _username = '';
String _email = '';
  final Color defaultBackgroundColor =  Color.fromARGB(255, 207, 214, 239);
  final Color defaultBorderColor =  Color.fromARGB(255, 156, 183, 236);

  final Color pressedBackgroundColor = const Color(0xFF6D94D9);
  final Color pressedBorderColor = const Color(0xFF3D5A9B);
 
 @override
void initState() {
  super.initState();
  loadUsername();
}
void loadUsername() async {
  final prefs = await SharedPreferences.getInstance();
  setState(() {
    _username = prefs.getString('username') ?? 'Guest';
    _email = prefs.getString('email') ?? 'Not provided';
  });
}


  void handleButtonPress(String buttonName, VoidCallback action) {
    setState(() {
      _activeButton = buttonName;
    });

    // بعد 300 ملي ثانية، يرجع الزر للونه الطبيعي
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _activeButton = null;
      });
    });

    // تنفيذ الفعل المرتبط بالزر
    action();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 233, 245),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 229, 233, 245),
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Color.fromARGB(255, 25, 101, 163),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
         iconTheme: const IconThemeData(
          size: 24,
          color:Color.fromARGB(255, 25, 101, 163),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('images/Screenshot 2025-04-27 145329.png'),
              ),
            ),
            const SizedBox(height: 20),
            ///////////UserName///////////////
Text(
  _username,
  style: const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Color.fromARGB(255, 5, 29, 72),
  ),
),
const SizedBox(height: 8),
Text(
  _email,
  style: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color.fromARGB(255, 56, 62, 99),
  ),
),
const SizedBox(height: 10),
            buildButton("Account", () {
              handleButtonPress("Account", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AccountPage()),
                );
              });
            }),
            buildButton("Settings", () {
              handleButtonPress("Settings", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              });
            }),
            buildButton("Translation History", () {
              handleButtonPress("Translation History", () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TranslationHistoryPage()),
                );
              });
            }),
             buildButton("About Glove", () {
              handleButtonPress("About Glove", () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GloveSettings()),
                );
              });
            }),
            buildButton("Help", () {
              handleButtonPress("Help", () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpPage()),
                );
              });
            }),
          ],
        ),
      ),

      ////////////////// bottomNavigationBar //////////////////
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 60,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromARGB(255, 205, 210, 248),
              Color.fromARGB(255, 229, 231, 246),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              icon: const Icon(Icons.home_rounded, color: Color.fromARGB(255, 5, 29, 72), size: 28),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person, color: Color.fromARGB(255, 5, 29, 72), size: 28),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
              icon: const Icon(Icons.settings, color: Color.fromARGB(255, 5, 29, 72), size: 28),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String text, VoidCallback onPressed) {
    final bool isPressed = (_activeButton == text);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 45),
          backgroundColor: isPressed ? pressedBackgroundColor : defaultBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: isPressed ? pressedBorderColor : defaultBorderColor,
              width: 2,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 3, 7, 22)),
        ),
      ),
    );
  }
}
