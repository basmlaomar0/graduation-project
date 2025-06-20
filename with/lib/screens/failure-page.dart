// ignore: file_names
import 'package:flutter/material.dart';
import 'package:grad_project/screens/blutooth.dart';

class FailurePage extends StatefulWidget {
  const FailurePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FailurePageState createState() => _FailurePageState();
}

class _FailurePageState extends State<FailurePage> {
  bool _isBackPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 226, 251),
      appBar: AppBar(
       backgroundColor: Color.fromARGB(255, 226, 226, 251),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Image.asset(
                'images/Light Mode Error.png',
                width: 330,
                height: 350,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 0),
              Text(
                "FAILED!",
                style: TextStyle(
                  color: Color.fromARGB(255, 220, 114, 90),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'An error occurred, please try again.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 51, 67, 98),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
             
              Text(
                "If the issue persists, please contact support.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:  Color.fromARGB(255, 51, 67, 98),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //  SizedBox(height: 5),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              //   padding: EdgeInsets.all(6),
              //  width: MediaQuery.of(context).size.width * 0.9,

              //   height: 120,
              //   decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //       begin: Alignment.centerLeft,
              //       end: Alignment.centerRight,
              //       colors: [
              //         Color.fromARGB(255, 240, 157, 132),
              //         Color.fromARGB(255, 245, 182, 172),
              //       ],
              //     ),
              //     borderRadius: BorderRadius.circular(16),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Color.fromARGB(255, 101, 107, 172).withOpacity(0.4),
              //         spreadRadius: 3,
              //         blurRadius: 8,
              //         offset: Offset(0, 4),
              //       ),
              //     ],
              //   ),
              //   child: Row(
              //     children: [
              //       Padding(
              //         padding: EdgeInsets.all(10),
              //         child: ClipRRect(
              //           borderRadius: BorderRadius.circular(10),
              //           child: SizedBox(
              //             width: 100,
              //             height: 100,
              //             child: Image.asset(
              //               'images/Glove.png',
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(width: 1),
              //       Padding(
              //         padding: const EdgeInsets.only(top: 10, left: 10),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Text(
              //               'Right Glove',
              //               style: TextStyle(
              //                 color: Color.fromARGB(255, 9, 14, 24),
              //                 fontSize: 18,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //             Icon(
              //               Icons.battery_5_bar_sharp,
              //               color: const Color.fromARGB(255, 20, 10, 8),
              //             ),
              //             Text(
              //               'Right Hand',
              //               style: TextStyle(
              //                 color: Color.fromARGB(255, 9, 14, 24),
              //                 fontSize: 15,
              //               ),
              //             ),
              //             Text(
              //               'disconnected',
              //               style: TextStyle(
              //                 color: Color.fromARGB(255, 226, 35, 32),
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: 150),
              GestureDetector(
                onTapDown: (_) => setState(() => _isBackPressed = true),
                onTapUp: (_) {
                  setState(() => _isBackPressed = false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectDevicePage()),
                  );
                },
                onTapCancel: () => setState(() => _isBackPressed = false),
                child: Container(
                  width: 250,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _isBackPressed
                        ? Color.fromARGB(255, 64, 121, 236)
                        :Color.fromARGB(255, 227, 227, 247),
                    border: Border.all(
                      color: Color.fromARGB(255, 136, 160, 208),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Try again",
                    style: TextStyle(
                      color: _isBackPressed
                          ? Colors.white
                          : Color.fromARGB(255, 44, 55, 77),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
                SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
