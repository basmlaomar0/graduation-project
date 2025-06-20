// ignore: file_names
import 'package:flutter/material.dart';
import 'package:grad_project/screens/home-page.dart';
import 'package:grad_project/screens/profile.dart';
import 'package:grad_project/screens/settings.dart';

class GloveSettings extends StatelessWidget {
  const GloveSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
       backgroundColor:Color.fromARGB(255, 215, 221, 243),
      appBar: AppBar(
         backgroundColor:Color.fromARGB(255, 215, 221, 243),
        title:const Text("About Glove",
        style: TextStyle(
            color: Color.fromARGB(255, 25, 101, 163),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),),
         iconTheme: const IconThemeData(
          size: 24,
          color:Color.fromARGB(255, 25, 101, 163),
        ),
      ),
     
      body: Column(
        children: [
          // الصورة تاخد المساحة المتاحة كلها بشكل تلقائي
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                "images/All Signs.png",
                width: screenWidth,
                fit: BoxFit.contain, // يمكنك تجربة BoxFit.cover أو BoxFit.fitWidth حسب الشكل المطلوب
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  width: screenWidth * 0.9,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 181, 197, 241),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()),
                          );
                        },
                        icon: const Icon(
                          Icons.home_rounded,
                          color: Color.fromARGB(255, 5, 29, 72),
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 35),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Profile()),
                          );
                        },
                        icon: const Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 5, 29, 72),
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 35),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SettingsPage()),
                          );
                        },
                        icon: const Icon(
                          Icons.settings,
                          color: Color.fromARGB(255, 5, 29, 72),
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
