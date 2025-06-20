// ignore: file_names
import 'package:flutter/material.dart';
import 'package:grad_project/screens/blutooth.dart';
import 'package:grad_project/screens/home-page.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  bool _isBackPressed = false;
  bool _isNextPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(255, 226, 226, 251),
      appBar: AppBar(
       backgroundColor: Color.fromARGB(255, 226, 226, 251),
        automaticallyImplyLeading: false,/////سهم الرجوع غير متواجد
        // title: Text("            "),
         elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'images/Light Mode Confirm.png',
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(
                "SUCCESS!",
                style: TextStyle(
                  color: Color.fromARGB(255, 25, 88, 216),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Your device was successfully paired.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 9, 14, 24),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Click 'next' to get started with using the app",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 9, 14, 24),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "If you don't have a pair yet you can order them by clicking on 'order'",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 9, 14, 24),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                padding: EdgeInsets.all(6),
               width: MediaQuery.of(context).size.width * 0.9,

                height: 130,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.fromARGB(255, 175, 226, 189),
                      Color.fromARGB(255, 220, 228, 224),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Color.fromARGB(255, 101, 107, 172).withOpacity(0.4),
                      spreadRadius: 3,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset(
                            'images/Glove.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 1),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Right Glove',
                            style: TextStyle(
                              color: Color.fromARGB(255, 9, 14, 24),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.battery_5_bar_sharp,
                            color: Colors.green,
                          ),
                          Text(
                            'Right Hand',
                            style: TextStyle(
                              color: Color.fromARGB(255, 9, 14, 24),
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Connected',
                            style: TextStyle(
                              color: Color.fromARGB(255, 68, 173, 106),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                         Navigator.push(
                        context,
                         MaterialPageRoute(
                          builder: (context) => SelectDevicePage(),
                           ),
                        );
                      },
                      onTapDown: (_) => setState(() => _isBackPressed = true),
                      onTapUp: (_) {
                        setState(() => _isBackPressed = false);
                        // Action for back
                      },
                      onTapCancel: () => setState(() => _isBackPressed = false),
                      child: Container(
                        width: 130,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _isBackPressed
                              ?Color.fromARGB(255, 64, 121, 236)
                              : Color.fromARGB(255, 240, 240, 253),
                          border: Border.all(
                            color: Color.fromARGB(255, 136, 160, 208),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Back",
                          style: TextStyle(
                            color: _isBackPressed
                                ? Colors.white
                                : Color.fromARGB(255, 25, 88, 216),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),


                    SizedBox(width: 30),
                    GestureDetector(
                      onTapDown: (_) => setState(() => _isNextPressed = true),
                         onTapUp: (_) {
    setState(() => _isNextPressed = false);
    // الانتقال لصفحة الهوم بدون رجوع
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  },
  onTapCancel: () => setState(() => _isNextPressed = false),
   child: Container(
                        width: 130,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _isNextPressed
                              ? Color.fromARGB(255, 64, 121, 236)
                              : Color.fromARGB(255, 240, 240, 253),
                          border: Border.all(
                            color:  Color.fromARGB(255, 136, 160, 208),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: _isNextPressed
                                ? Colors.white
                                : Color.fromARGB(255, 25, 88, 216),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
             SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}