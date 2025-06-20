// ignore: file_names
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/screens/add-device.dart';
import 'package:grad_project/screens/login-button.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';


class SignUpButton extends StatefulWidget {
  const SignUpButton({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpButtonState createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool isSignUpPressed = false;
  bool isLoginPressed = false;
  bool _isLoading = false;
  String? _error;
  

  
  InputDecoration _inputDecoration(String label, IconData icon) {
  return InputDecoration(
    labelText: label,
    labelStyle: TextStyle(
      color: Color.fromARGB(255, 146, 168, 220),
      fontWeight: FontWeight.w500,
    ),
    prefixIcon: Icon(icon, color: Color.fromARGB(255, 146, 168, 220)),
    filled: true,
    fillColor: const Color.fromARGB(255, 199, 203, 243),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color:const Color.fromARGB(255, 215, 218, 244),
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
  ////////لتفادي تسرب الذاكرة
@override
void dispose() {
  _emailController.dispose();
  _passwordController.dispose();
  _confirmPasswordController.dispose();
  _userNameController.dispose();
  super.dispose();
}

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final username = _userNameController.text.trim();

    if (email.isEmpty || password.isEmpty || username.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        _error = "All fields are required.";
        _isLoading = false;
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _error = "Passwords do not match.";
        _isLoading = false;
      });
      return;
    }
try {
  UserCredential userCredential = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password);
  User? user = userCredential.user;

  if (user != null) {
    await user.updateDisplayName(username);

    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'username': username,
      'email': email,
      });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Signup successful!")),
    );

    await Future.delayed(Duration(milliseconds: 500));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AddDevice()),
    );
    
  }
}


/////////////////////////////////////////////////////
    on FirebaseAuthException catch (e) {
      if (mounted) {
      setState(() {
        _error = e.message;
      });
      }
    } finally {
       if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
    }
  }
  
////////////UI///////////////UI///////////////UI////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Color.fromARGB(255, 227, 227, 247),
      
      appBar: AppBar(title: Text("             "),
       backgroundColor:Color.fromARGB(255, 227, 227, 247),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign up!",
                  style: TextStyle(
                    color: Color.fromARGB(255, 25, 88, 216),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Enter your email, username and password to sign up.\nYou can change your username from profile settings.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  "By signing up you agree to all terms of service.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, color: Colors.black),
                ),
                SizedBox(height: 30),

                // 🟦 TextFields
                if (_error != null)
                  Text(_error!, style: TextStyle(color: Colors.red)),
                SizedBox(height: 10),

                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _inputDecoration("Email", Icons.email),
                ),
                SizedBox(height: 15),

                TextField(
                  controller: _userNameController,
                  decoration: _inputDecoration("Username", Icons.person),
                ),
                SizedBox(height: 15),

                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: _inputDecoration("Password", Icons.lock),
                ),
                SizedBox(height: 15),

                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: _inputDecoration("Confirm Password", Icons.lock_outline),
                ),
                SizedBox(height: 25),

                // 🟪 Sign Up Button
                _isLoading
                    ? CircularProgressIndicator()
                    : GestureDetector(
                        onTapDown: (_) {
                          setState(() {
                            isSignUpPressed = true;
                          });
                        },
                        onTapUp: (_) {
                          setState(() {
                            isSignUpPressed = false;
                          });
                          _signUp();
                        },
                        onTapCancel: () {
                          setState(() {
                            isSignUpPressed = false;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 200,
                          height: 45,
                          decoration: BoxDecoration(
                            color: isSignUpPressed
                                ? Color.fromARGB(255, 114, 105, 234)
                                : Color.fromARGB(255, 222, 233, 252),
                            border: Border.all(
                              color: Color.fromARGB(255, 114, 105, 234),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: isSignUpPressed ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: 20),

                        Text(
                          "Already have an account?",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 53, 52, 52)),
                        ),
                        SizedBox(height: 10),

                // 🟩 Login Button
                GestureDetector(
                  onTap: () {
                    
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                  },
                  onTapDown: (_) {
                    setState(() {
                      isLoginPressed = true;
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      isLoginPressed = false;
                    });
                    // يمكنك إضافة وظيفة عند الضغط على زر تسجيل الدخول إذا لزم الأمر
                  },
                  onTapCancel: () {
                    setState(() {
                      isLoginPressed = false;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 45,
                    decoration: BoxDecoration(
                      color: isLoginPressed
                          ?Color.fromARGB(255, 114, 105, 234)
                          : Color.fromARGB(255, 222, 233, 252),
                      border: Border.all(
                        color:Color.fromARGB(255, 114, 105, 234),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: isLoginPressed ? Colors.white : Colors.black,
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
    );
  }
}
