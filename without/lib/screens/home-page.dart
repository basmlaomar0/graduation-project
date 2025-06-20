import 'package:flutter/material.dart';
import 'package:grad_project/screens/add-device.dart';
import 'package:grad_project/screens/glove-settings.dart';
import 'package:grad_project/screens/glove-stream.dart';
import 'package:grad_project/screens/help-page.dart';
import 'package:grad_project/screens/profile.dart';
import 'package:grad_project/screens/settings.dart';
import 'package:grad_project/screens/transcribe.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  
  @override
  void initState() {
    super.initState();
    // _reloadListener();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
     
    });
  }
  
// Future<void> _reloadListener() async {
//     if (connection != null) {
//       connection!.input!.listen((event) {
       
         
//         })
//         ..onData((data) {
//           print("The Data from the connection ++++++++++=====> \n");
//           print(ascii.decode(data));
//           print("++++++++++=====>\n ");
//         })
//         ..onDone(() {
//           print("Strem is");
//         },
//         );
//         }}


  Future<void> _disconnectGlove() async {
  // مثال: لو تستخدمين SharedPreferences لتخزين حالة التوصيل
  // import 'package:shared_preferences/shared_preferences.dart';
  
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('glove_connected', false); // تحديث حالة الاتصال

  // لو عندك Bluetooth:
  // await yourBluetoothInstance.disconnect();  <-- افصلي الجلاف هنا

  print("Glove disconnected!");
}

  ////////////////////Ui//////////UI///////////////UI//////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:Color.fromARGB(255, 198, 208, 245),
      appBar: PreferredSize(
  preferredSize: Size.fromHeight(70), // ارتفاع الـ AppBar
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10), // البادينج اللي تبغيه
    child: AppBar(
      backgroundColor:Color.fromARGB(255, 198, 208, 245),
      automaticallyImplyLeading: false,/////سهم الرجوع غير متواجد
      elevation: 0,
      title: Text(
        'Home',
        style: TextStyle(
          color: Color.fromARGB(255, 34, 45, 134),
          fontSize: 27,
          fontWeight: FontWeight.bold,
        ),
      ),
     actions: [
      
// IconButton(
//                 icon: Icon(
//                   Icons.refresh,
//                   color: Color.fromARGB(255, 5, 29, 72),
//                   size: 28,
//                 ),
//                 onPressed: () {
//                   _reloadListener();
//                 },
//               ),
  IconButton(
    icon: Icon(
      Icons.help_outline,
      color: Color.fromARGB(255, 5, 29, 72),
      size: 28,
    ),
   onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => HelpPage(),
    ),
  );
  },
  ),
],
    ),
  ),
),

        body:
        Container(
           decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
             Color.fromARGB(255, 198, 208, 245),
             Color.fromARGB(255, 198, 208, 245),
             Color.fromARGB(255, 198, 208, 245),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // يخلي النصوص تبدأ من اليسار
            children: [

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: Text(
          'Welcome back!',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: const Color.fromARGB(255, 73, 134, 240),
            fontSize: 20,
          ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text(
          'Your device are ready ....',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: const Color.fromARGB(255, 54, 63, 78),
            fontSize: 14,
          ),
                ),
              ),

              SizedBox(height: 16,),
 ///////////////////////////////////////////////
          Padding(
  padding: const EdgeInsets.only(right: 12, left: 12),
  child: Align(
    alignment: Alignment.centerRight,
    child: Container(
      width: 400,
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromARGB(255, 119, 134, 247), // غامق شوية
            Color.fromARGB(255, 182, 188, 235), // فاتح
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // المحتوى الأساسي
          Center(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 140,
                      height: 140,
                      child: Image.asset(
                        'images/Glove.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
               Padding(
  padding: const EdgeInsets.only(top: 18, left: 15, right: 10),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        'Right Glove',
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Color.fromARGB(255, 9, 14, 24),
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
      Icon(
        Icons.battery_5_bar_sharp,
        color: Colors.green,
      ),
      SizedBox(height: 5),
      Text(
        'Right Hand',
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Color.fromARGB(255, 9, 14, 24),
          fontSize: 15,
        ),
      ),
      Text(
        'Connected',
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Color.fromARGB(255, 22, 151, 69),
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 10),

///////////////////// زر Remove//////////////////////
      Padding(
        padding: const EdgeInsets.only(top: 4),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 11, 4, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: const Color.fromARGB(255, 219, 144, 121),
                            size: 28,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Remove GloveGI',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 219, 144, 121),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'You are about to remove a device.',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 249, 237, 230),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Are you sure you want to continue?',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 249, 237, 230),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 94, 61, 52)),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                        padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 35, vertical: 10)),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 231, 144, 120)),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                        padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                      ),
                      child: Text(
                        "Remove",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        await _disconnectGlove(); // وظيفتك لفصل الجلاف
                        Navigator.of(context).pop();
                        setState(() {
                          // تحديث الحالة إذا لزم الأمر
                        });
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 90,
              height: 35,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                     Color.fromARGB(255, 230, 94, 96),
                      Color.fromARGB(255, 239, 145, 140),
                    Color.fromARGB(255, 247, 198, 207),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  'Remove',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 9, 1, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
///////////////////// زر Remove//////////////////////
      
    ],
  ),
)

              ],
            ),
          ),
          // أيقونة في أعلى اليمين
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: Icon(Icons.settings, color: const Color.fromARGB(255, 11, 3, 3)),
              onPressed: () {
                Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => GloveSettings(),
                         ),
                       );
              },
            ),
          ),
        ],
      ),
    ),
  ),
),

 ///////////////////////////////////////////////
           SizedBox(height: 16,),
           GestureDetector(
           onTap: () {
             Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => AddDevice()),
             );
           },
           child: Padding(
             padding: const EdgeInsets.only(right: 12, left: 12),
             child: Align(
               alignment: Alignment.centerRight,
               child: Container(
                 width: 400,
                 height: 55,
                 decoration: BoxDecoration(
                   gradient: LinearGradient(
                     begin: Alignment.centerLeft,
                     end: Alignment.centerRight,
                     colors: [
                       Color.fromARGB(255, 119, 134, 247), // غامق شوية
              Color.fromARGB(255, 182, 188, 235), // فاتح
                     ],
                   ),
                   borderRadius: BorderRadius.circular(16),
                   boxShadow: [
                     BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.grey.withOpacity(0.4),
             spreadRadius: 1,
             blurRadius: 6,
             offset: Offset(4, 4),
                     ),
                   ],
                 ),
                 child: Center(
                   child: Text(
                     '+ Add Device',
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       color: Color.fromARGB(255, 16, 20, 28),
                       fontSize: 20,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                 ),
               ),
             ),
           ),
           ),
           SizedBox(height: 12,),
                    Align(
           alignment: Alignment.center,
           child: Padding(
             padding: EdgeInsets.all(10),
             child: GestureDetector(
               onTap: () {
                 showDialog(
                   context: context,
                   builder: (BuildContext context) {
                     return AlertDialog(
                       backgroundColor: const Color.fromARGB(255, 105, 117, 249),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(20),
                         side: BorderSide(color: Colors.white, width: 2),
                       ),
                       content: SizedBox(
                         width: MediaQuery.of(context).size.width,
                         height: MediaQuery.of(context).size.height,
                         child: TranscribePage(),
                       ),
                     );
                   },
                 );
               },
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(12),
                 child: Container(
                   width: 380,
                   height: 100,
                   decoration: BoxDecoration(
           gradient: LinearGradient(
             begin: Alignment.centerLeft,
             end: Alignment.centerRight,
             colors: [
               Color.fromARGB(255, 119, 134, 247),
               Color.fromARGB(255, 182, 188, 235),
             ],
           ),
           borderRadius: BorderRadius.circular(12),
           boxShadow: [
             BoxShadow(
               color: Colors.grey.withOpacity(0.4),
               spreadRadius: 1,
               blurRadius: 6,
               offset: Offset(4, 4),
             ),
           ],
           ),
           
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(Icons.mic, size: 30, color:Color.fromARGB(255, 16, 20, 28)
           ),
                       SizedBox(height: 6),
                       Text(
                         'Transcribe',
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 18,
                           color: Color.fromARGB(255, 16, 20, 28),
                         ),
                       ),
                       SizedBox(height: 2),
                       Text(
                         'Show gesture transcribed text.',
                         style: TextStyle(
                           fontSize: 12,
                           color:Color.fromARGB(255, 16, 20, 28)
           ,
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
             
             ),
             
           ),
           ),
           
                   
                     ///////////////////////lowBar
                   Spacer(flex: 1,),
                   Padding(
                     padding: EdgeInsets.only(bottom: 20),
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Container(
                   margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                   padding: EdgeInsets.symmetric(horizontal: 12),
                   width: 360,
                   height: 50,
                   decoration: BoxDecoration(
                   gradient: LinearGradient(
                     begin: Alignment.centerLeft,
                     end: Alignment.centerRight,
                     colors: [
                       Color.fromARGB(255, 205, 210, 248),
                       Color.fromARGB(255, 229, 231, 246),
                     ],
                   ),
                   borderRadius: BorderRadius.circular(16),
                   
                 ),
                   child: Row( // لازم Row هنا علشان نرتب الأيقونات جنب بعض
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       IconButton(
                         onPressed: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => HomePage(),
                         ),
                       );
                         },
                         icon: Container(
                           padding: EdgeInsets.all(8),
                           child: Icon(
                             Icons.home_rounded,
                             color: Color.fromARGB(255, 5, 29, 72),
                             size: 28,
                           ),
                         ),
                       ),
                       SizedBox(width: 35),
                       IconButton(
                         onPressed: () {
                           Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => Profile(),
                         ),
                       );
                         },
                         icon: Container(
                           padding: EdgeInsets.all(8),
                           child: Icon(
                             Icons.person,
                             color: Color.fromARGB(255, 5, 29, 72),
                             size: 28,
                           ),
                         ),
                       ),
                        SizedBox(width: 35),
                       IconButton(
                         onPressed: () {
                           Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => SettingsPage(),
                         ),
                       );
                         },
                         icon: Container(
                           padding: EdgeInsets.all(8),
                           child: Icon(
                             Icons.settings,
                             color: Color.fromARGB(255, 5, 29, 72),
                             size: 28,
                           ),
                         ),
                       ),
                     ],
                   ),
                         ),
                       ],
                     ),
                   )
                   ,
                     ],
          ),
        ),
      );
  }
}