import 'package:flutter/material.dart';
import 'package:grad_project/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:grad_project/screens/signup-button.dart';

// import 'signup_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  Future<void> _completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);

    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (_) => SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 228, 253),
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
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 SizedBox(height: 30),
                Text(
                  "Welcome to MUTE!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 25, 88, 216),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  "Your assistant for sign language transcription.\nGet started by creating your account.",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () => _completeOnboarding(context),
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 226, 226, 245),
                      border: Border.all(
                        color: Color.fromARGB(255, 85, 75, 231),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
