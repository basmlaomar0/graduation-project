import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grad_project/screens/add-device.dart';
import 'package:grad_project/screens/login-button.dart';
import 'package:grad_project/screens/signup-button.dart';
///////////////////////////////
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  if (googleUser == null) return; // Cancelled by user

  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  await FirebaseAuth.instance.signInWithCredential(credential);
}
///////////////////////////////
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // حالات الضغط لكل زر
  bool isSignUpPressed = false;
  bool isGooglePressed = false;
  bool isLoginPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 233, 235, 250),
      appBar: AppBar( 
         backgroundColor:Color.fromARGB(255, 204, 204, 246),
        title: Text("   "),
      ),
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
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/Light Mode Login.png',
              width: 280,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 30,),
            Text(
              "Get started by signing up!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 25, 88, 216),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'login or sign up to start using/managing your ',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(255, 9, 14, 24),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Glove unit',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(255, 9, 14, 24),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'you might get extra steps, its your first time',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(255, 9, 14, 24),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
        
            // === الزر Sign Up ===
            GestureDetector(
              onTapDown: (_) => setState(() => isSignUpPressed = true),
              onTapUp: (_) => setState(() => isSignUpPressed = false),
              onTapCancel: () => setState(() => isSignUpPressed = false),
              onTap: () {
                
                  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpButton(),
                ),
              );
              },
              child: buildButton('Sign Up', isSignUpPressed),
            ),
            SizedBox(height: 10),
        
            // === الزر Sign in with Google ===
            GestureDetector(
              onTapDown: (_) => setState(() => isGooglePressed = true),
              onTapUp: (_) => setState(() => isGooglePressed = false),
              onTapCancel: () => setState(() => isGooglePressed = false),
              onTap: () async {
              setState(() => isGooglePressed = true);
              await signInWithGoogle();
              setState(() => isGooglePressed = false);
        
              // بعد الدخول، مثلاً تنتقل للشاشة الرئيسية
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddDevice(),
          ),
        );
        
              },
              child: buildButton(
                'Sign in with Google',
                isGooglePressed,
                icon: FaIcon(FontAwesomeIcons.google, size: 24),
              ),
            ),
            SizedBox(height: 10),
        
            // === الزر Login ===
            GestureDetector(
              onTapDown: (_) => setState(() => isLoginPressed = true),
              onTapUp: (_) => setState(() => isLoginPressed = false),
              onTapCancel: () => setState(() => isLoginPressed = false),
              onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  LoginPage(),
                ),
              );
               
              },
              child: buildButton('Login', isLoginPressed),
            ),
            SizedBox(height: 50),
        
          ],
          
        ),
      ),
    );
  }

  // إعادة استخدام بناء الأزرار
  Widget buildButton(String text, bool isPressed, {Widget? icon}) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Align(
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: isPressed
                  ? Color.fromARGB(255, 158, 168, 221) // عند الضغط
                  : Color.fromARGB(225, 239, 231, 244), // اللون الأساسي
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.blueAccent,
                width: 3,
              ),
            ),
            width: 240,
            height: 40,
            child: Center(
              child: icon != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon,
                        SizedBox(width: 10),
                        Text(text),
                      ],
                    )
                  : Text(text),
            ),
          ),
        ),
      ),
    );
  }
}
