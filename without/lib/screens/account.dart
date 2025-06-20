import 'package:flutter/material.dart';
import 'package:grad_project/screens/home-page.dart';
import 'package:grad_project/screens/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String _selectedGender = 'Male';
  String _username = 'Ahmednashat';
  String _email = 'Ahmednashat@gmail.com';
  String _password = '********';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? '';
      _email = prefs.getString('email') ?? '';
      _password = prefs.getString('password') ?? '********';
      _selectedGender = prefs.getString('gender') ?? 'Male';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 198, 208, 245),
      appBar: AppBar(
         backgroundColor:Color.fromARGB(255, 198, 208, 245),
        title: Text(
          "Account",
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30, left: 10),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('images/Screenshot 2025-04-27 145329.png'),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Account info",
              style: TextStyle(
                color: const Color.fromARGB(255, 8, 10, 14),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),

           ////ُEmail
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email:",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 65, 75, 96),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    Text(_email,
                        style: TextStyle(
                            color: const Color.fromARGB(255, 65, 75, 96),
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                // buildEditButton(() {
                //   _showEditDialog(
                //     title: 'Edit Email',
                //     initialValue: _email,
                //     onConfirm: (value) async {
                //       try {
                //         User? user = FirebaseAuth.instance.currentUser;
                //         await user!.updateEmail(value);
                //         await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
                //           'email': value,
                //         });
                //         SharedPreferences prefs = await SharedPreferences.getInstance();
                //         await prefs.setString('email', value);
                //         setState(() {
                //           _email = value;
                //         });
                //       } catch (e) {
                //         print("Error updating email: $e");
                //       }
                //     },
                //   );
                // }),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Username
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Username:",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 65, 75, 96),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    Text(_username,
                        style: TextStyle(
                            color: const Color.fromARGB(255, 65, 75, 96),
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                buildEditButton(() {
                  _showEditDialog(
                    title: 'Edit Username',
                    initialValue: _username,
                    onConfirm: (value) async {
                      try {
                        User? user = FirebaseAuth.instance.currentUser;
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
                          'username': value,
                          'gender': _selectedGender,
                        });
                        await prefs.setString('username', value);
                        await prefs.setString('gender', _selectedGender);
                        setState(() {
                          _username = value;
                        });
                      } catch (e) {
                        print("Error updating username: $e");
                      }
                    },
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: 20),

          

          // Gender Dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Gender",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 65, 75, 96),
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 143, 143, 237),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedGender,
                    dropdownColor: const Color.fromARGB(255, 143, 143, 237),
                    icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                    underline: SizedBox(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (String? newValue) async {
                      if (newValue == null) return;
                      try {
                        User? user = FirebaseAuth.instance.currentUser;
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
                          'username': _username,
                          'gender': newValue,
                        });
                        await prefs.setString('gender', newValue);
                        setState(() {
                          _selectedGender = newValue;
                        });
                      } catch (e) {
                        print("Error updating gender: $e");
                      }
                    },
                    items: <String>['Male', 'Female']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Password ",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 65, 75, 96),
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                buildEditButton(() {
                  _showEditDialog(
                    title: 'Edit password',
                    initialValue: _password,
                    onConfirm: (value) async {
                      try {
                        User? user = FirebaseAuth.instance.currentUser;
                        await user!.updatePassword(value);
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setString('password', value);
                        setState(() {
                          _password = value;
                        });
                      } catch (e) {
                        print("Error updating password: $e");
                      }
                    },
                  );
                }),
              ],
            ),
          ),

          Spacer(),
          buildBottomNavBar(context),
        ],
      ),
    );
  }

  Widget buildEditButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 92,
          height: 45,
          color: const Color.fromARGB(255, 143, 143, 237),
          child: Center(
            child: Text(
              'Edit',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }

  void _showEditDialog({
    required String title,
    required String initialValue,
    required Function(String) onConfirm,
  }) {
    TextEditingController controller = TextEditingController(text: initialValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: "Enter new value"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              onConfirm(controller.text);
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  Widget buildBottomNavBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 12),
          width: 360,
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                },
                icon: Icon(Icons.home_rounded,
                    color: Color.fromARGB(255, 5, 29, 72), size: 28),
              ),
              SizedBox(width: 35),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AccountPage()));
                },
                icon: Icon(Icons.person,
                    color: Color.fromARGB(255, 5, 29, 72), size: 28),
              ),
              SizedBox(width: 35),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                },
                icon: Icon(Icons.settings,
                    color: Color.fromARGB(255, 5, 29, 72), size: 28),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
