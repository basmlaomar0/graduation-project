// ignore: file_names
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/screens/home-page.dart';
import 'package:grad_project/screens/signup-button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoginPressed = false;
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Color.fromARGB(255, 146, 168, 220),
        fontWeight: FontWeight.w500,
      ),
      prefixIcon: Icon(icon, color: Color.fromARGB(255, 146, 168, 220)),
      filled: true,
      fillColor: const Color.fromARGB(255, 227, 231, 247),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: const Color.fromARGB(255, 215, 218, 244),
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 85, 75, 231),
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
    );
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _error = "All fields are required.";
        _isLoading = false;
      });
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        // Get user data from Firestore
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (doc.exists) {
          final username = doc.data()?['username'] ?? '';
          final email = doc.data()?['email'] ?? '';

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('username', username);
          await prefs.setString('email', email);
        }

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful!")),
        );

        await Future.delayed(Duration(milliseconds: 500));

        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _error = e.message;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 233, 235, 250),
      appBar: AppBar(
        title: Text(""),
        backgroundColor:Color.fromARGB(255, 204, 204, 246),
        elevation: 0,
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Welcome Back!",
                            style: TextStyle(
                              color: Color.fromARGB(255, 25, 88, 216),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Login to continue using your glove!",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                          SizedBox(height: 20),
                          if (_error != null)
                            Text(_error!, style: TextStyle(color: Colors.red)),
                          SizedBox(height: 10),
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: _inputDecoration("Email", Icons.email_outlined),
                          ),
                          SizedBox(height: 15),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: _inputDecoration("Password", Icons.lock_outline),
                          ),
                          SizedBox(height: 25),
                          _isLoading
                              ? CircularProgressIndicator()
                              : GestureDetector(
                                  onTapDown: (_) {
                                    setState(() => isLoginPressed = true);
                                  },
                                  onTapUp: (_) {
                                    setState(() => isLoginPressed = false);
                                    _login();
                                  },
                                  onTapCancel: () {
                                    setState(() => isLoginPressed = false);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 200,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: isLoginPressed
                                          ? Color.fromARGB(255, 114, 105, 234)
                                          : Color.fromARGB(255, 233, 235, 250),
                                      border: Border.all(
                                        color: Color.fromARGB(255, 114, 105, 234),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: isLoginPressed
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(height: 20),
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                                fontSize: 12, color: Color.fromARGB(255, 53, 52, 52)),
                          ),
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpButton()),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 200,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 233, 235, 250),
                                border: Border.all(
                                  color: Color.fromARGB(255, 114, 105, 234),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
