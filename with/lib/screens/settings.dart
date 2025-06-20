import 'package:flutter/material.dart';
import 'package:grad_project/screens/home-page.dart';
import 'package:grad_project/screens/profile.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool status = true;
  bool statuscolor = true;
  String selectedLanguage = 'English';
  String selectedVoice = 'Male';

final FlutterTts flutterTts = FlutterTts();
List<dynamic> voices = [];

void loadSelectedSettings() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  selectedVoice = prefs.getString('voice') ?? 'Male'; // احفظ الإعدادات السابقة
   selectedLanguage = prefs.getString('language') ?? 'English';
  
  setState(() {});
}

@override
void initState() {
  super.initState();
  loadVoices(); 
  loadSelectedSettings();
 // تحميل الصوت المختار مسبقاً
}
void loadVoices() async {
  voices = await flutterTts.getVoices;
  setState(() {});
  print("Available voices:");
  for (var voice in voices) {
    final voiceMap = Map<String, dynamic>.from(voice as Map);
    print("${voiceMap['name']} - ${voiceMap['locale']}");
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:Color.fromARGB(255, 204, 213, 244),
      appBar: AppBar(
         backgroundColor:Color.fromARGB(255, 204, 213, 244),
        title: const Text(
          "Settings",
          style: TextStyle(
            color:  Color.fromARGB(255, 25, 101, 163),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          size: 24,
          color:Color.fromARGB(255, 25, 101, 163),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              "Translation",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
  padding: const EdgeInsets.only(left: 30, bottom: 15, right: 20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        "Language",
        style: TextStyle(
          color: Colors.blueGrey,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      Container(
        width: 100,
        height: 45,
        decoration: BoxDecoration(
    color: const Color.fromARGB(255, 143, 143, 237), // ✅ background color of the box
    borderRadius: BorderRadius.circular(10),
  ),
  alignment: Alignment.center,
        child: DropdownButton<String>(
          dropdownColor: const Color.fromARGB(255, 143, 143, 237),
          value: selectedLanguage,
          underline: const SizedBox(), // إلغاء الخط السفلي
          alignment: Alignment.center, // ✅ توسيط النص داخل الزر
    
          onChanged: (String? newValue) async {
  setState(() {
    selectedLanguage = newValue!;
  });

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('language', selectedLanguage); // ✅ حفظ اللغة
  
  // اختر الصوت الحالي تلقائيًا لنفس النوع المختار
  String gender = selectedVoice.toLowerCase();
  String locale = selectedLanguage == 'Arabic' ? 'ar' : 'en';

  var matchedVoice = voices.firstWhere(
    (voice) {
      final voiceMap = Map<String, dynamic>.from(voice as Map);
      final name = voiceMap['name']?.toString().toLowerCase() ?? '';
      final loc = voiceMap['locale']?.toString().toLowerCase() ?? '';
      return name.contains(gender) && loc.contains(locale);
    },
    orElse: () => null,
  );

  if (matchedVoice != null) {
    await flutterTts.setVoice(matchedVoice);
    print("Voice auto-set: ${matchedVoice['name']}");
  }
},

          items: ['English', 'Arabic']
              .map((lang) => DropdownMenuItem<String>(
                    value: lang,
                    child: Text(lang),
                  ))
              .toList(),
        ),
      ),
    ],
  ),
),
Padding(
  padding: const EdgeInsets.only(left: 30, bottom: 15, right: 20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        "Voice",
        style: TextStyle(
          color: Colors.blueGrey,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      Container(width: 100,
        height: 45,
        decoration: BoxDecoration(
    color: const Color.fromARGB(255, 143, 143, 237), // ✅ background color of the box
    borderRadius: BorderRadius.circular(10),
  ),
  alignment: Alignment.center,
        child: DropdownButton<String>(
          dropdownColor: const Color.fromARGB(255, 143, 143, 237),
          value: selectedVoice,
          underline: const SizedBox(), // إلغاء الخط السفلي
          alignment: Alignment.center, // ✅ توسيط النص داخل الزر
 onChanged: (String? newValue) async {
  setState(() {
    selectedVoice = newValue!;
  });

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('voice', selectedVoice);

            // اختار الصوت حسب اللغة والجنس
            String locale = selectedLanguage == 'Arabic' ? 'ar' : 'en';
            String gender = selectedVoice.toLowerCase();

            var matchedVoice = voices.firstWhere(
              (voice) {
                final voiceMap = Map<String, dynamic>.from(voice as Map);
                final name = voiceMap['name']?.toString().toLowerCase() ?? '';
                final loc = voiceMap['locale']?.toString().toLowerCase() ?? '';
                return name.contains(gender) && loc.contains(locale);
              },
              orElse: () => null,
            );

            if (matchedVoice != null) {
              await flutterTts.setVoice(matchedVoice);
              print("Voice set: ${matchedVoice['name']}");
            } else {
              print("No matching voice found.");
            }
          },

          items: ['Male', 'Female']
              .map((voice) => DropdownMenuItem<String>(
                    value: voice,
                    child: Text(voice),
                  ))
              .toList(),
        ),
      ),
    ],
  ),
),
const Divider(
  color: Colors.grey,
  thickness: 1,
  indent: 20,
  endIndent: 20,
),

          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              "Notifications",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 15, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Push Notifications",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch(
                  activeColor: const Color.fromARGB(255, 135, 135, 251),
                  value: status,
                  onChanged: (val) {
                    setState(() {
                      status = val;
                    });
                  },
                ),
              ],
            ),
          ),
          const Divider(
  color: Colors.grey,
  thickness: 1,
  indent: 20,
  endIndent: 20,
),

          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              "Activate Status",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
         Padding(
  padding: const EdgeInsets.only(left: 30, bottom: 10, right: 20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
     
      Row(
        children: const [
          // Icon(Icons.sms_rounded, color: Color.fromARGB(255, 15, 174, 39)), // أيقونة الشات
          SizedBox(width: 5), // مسافة صغيرة بين الأيقونة والنص
          Text(
            "Active now",
            style: TextStyle(
              color: Color.fromARGB(255, 15, 174, 39),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ],
  ),
),

          const Divider(
  color: Colors.grey,
  thickness: 1,
  indent: 20,
  endIndent: 20,
),
 
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              "About App",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
         Padding(
  padding: const EdgeInsets.only(left: 30, bottom: 10, right: 20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
     
      Row(
        children: const [
          // Icon(Icons.sms_rounded, color: Color.fromARGB(255, 15, 174, 39)), // أيقونة الشات
          SizedBox(width: 5), // مسافة صغيرة بين الأيقونة والنص
          Text(
            "App version 7.10.24",
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ],
  ),
),

         
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  width: 360,
                  height: 50,
                  decoration: BoxDecoration(
                    color:  const Color.fromARGB(255, 181, 197, 241),
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

