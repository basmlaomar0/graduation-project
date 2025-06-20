import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:grad_project/screens/glove-stream.dart'; // يجب تعريف connection
import 'package:grad_project/screens/history_storage.dart';
import 'package:grad_project/screens/lib/ml_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

class TranscribePage extends StatefulWidget {
  const TranscribePage({super.key});

  @override
  State<TranscribePage> createState() => _TranscribePageState();
}

class _TranscribePageState extends State<TranscribePage> {
  final FlutterTts flutterTts = FlutterTts();
  final translator = GoogleTranslator();

  late MLModel mlModel;

  Stream<Uint8List>? _bluetoothInputStream;
  StreamSubscription<List<int>>? _subscription;

  List<dynamic> voices = [];
  String selectedVoice = 'Male';
  String textToSpeak = "Welcome to Mute App";
  String currentGesture = "";
  String lastTransferText = '';

  @override
  void initState() {
    super.initState();
    mlModel = MLModel();
    mlModel.loadModel();

    initTTS();
    translateInitialText();

    print("📡 connection: $connection");
    startListeningToBluetooth();
  }

  void startListeningToBluetooth() {
    if (connection?.input == null) {
      print("⚠️ connection or input stream is null");
      return;
    }

    if (_subscription != null) {
      print("⚠️ Already listening to Bluetooth stream, skipping...");
      return;
    }

    _bluetoothInputStream ??= connection!.input!.asBroadcastStream();

    _subscription = _bluetoothInputStream!.listen(
      (event) async {
        try {
          final dataString = utf8.decode(event).trim();
          print("📥 Received raw data: $dataString");

          if (dataString.startsWith("[") && dataString.endsWith("]")) {
            final decoded = json.decode(dataString);

            if (decoded is List) {
              List<double> rowData =
                  decoded.map((e) => (e as num).toDouble()).toList();

              print("📤 Parsed data array: $rowData");

              if (lastTransferText != rowData.toString()) {
                lastTransferText = rowData.toString();

                int predictionIndex = mlModel.runModel(rowData);
                List<String> labels = [
                  'Bye',
                  'doctor',
                  'go',
                  'good',
                  'hello',
                  'help',
                  'hospital',
                  'I',
                  'I hate u',
                  'I love u',
                  'medicine',
                  'need',
                  'no',
                  'please',
                  'sorry',
                  'stop',
                  'thanks',
                  'tired',
                  'today',
                  'tomorrow',
                  'yes',
                  'yesterday',
                  'you'
                ];

                String gesture = labels[predictionIndex];
                print("🤖 Model Prediction Index: $predictionIndex");
                print("🧾 Predicted Gesture: $gesture");

                gloveStreamController.sink.add(gesture);
                await updateText(gesture);
              }
            } else {
              print("❌ Decoded JSON is not a list: $decoded");
            }
          } else {
            print("❌ Received data is not a JSON array");
          }
        } catch (e) {
          print("❌ Error processing Bluetooth data: $e");
        }
      },
      onError: (err) {
        print("❌ Bluetooth stream error: $err");
      },
      cancelOnError: true,
    );
  }

  Future<void> translateInitialText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String selectedLanguage = prefs.getString('language') ?? 'English';
    if (selectedLanguage.toLowerCase() == 'arabic') {
      var translation = await translator.translate(textToSpeak, to: 'ar');
      if (mounted) {
        setState(() {
          textToSpeak = translation.text;
        });
      }
    }
  }

  Future<void> initTTS() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      selectedVoice = prefs.getString('voice') ?? 'Male';
      String selectedLanguage = prefs.getString('language') ?? 'English';

      voices = await flutterTts.getVoices;
      String locale = selectedLanguage.toLowerCase() == 'arabic' ? 'ar' : 'en';
      String gender = selectedVoice.toLowerCase();

      final matchedVoice = voices.firstWhere(
        (voice) {
          if (voice is Map<String, dynamic>) {
            final name = voice['name']?.toString().toLowerCase() ?? '';
            final loc = voice['locale']?.toString().toLowerCase() ?? '';
            return name.contains(gender) && loc.contains(locale);
          }
          return false;
        },
        orElse: () {
          return voices.firstWhere(
            (voice) {
              if (voice is Map<String, dynamic>) {
                final loc = voice['locale']?.toString().toLowerCase() ?? '';
                return loc.contains(locale);
              }
              return false;
            },
            orElse: () => null,
          );
        },
      );

      if (matchedVoice != null) {
        await flutterTts.setVoice(matchedVoice);
        await flutterTts.setLanguage(locale == 'ar' ? 'ar-SA' : 'en-US');
      } else {
        await flutterTts.setLanguage(locale == 'ar' ? 'ar-SA' : 'en-US');
      }
    } catch (e) {
      print("initTTS error: $e");
    }
  }

  Future<void> speak() async {
    await flutterTts.speak(textToSpeak);
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }

  Future<void> pause() async {
    await flutterTts.pause();
  }

  Future<void> updateText(String newText) async {
    print("🟡 updateText called with: $newText");
    await stop();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String selectedLanguage = prefs.getString('language') ?? 'English';
    String originalText = newText;

    if (selectedLanguage.toLowerCase() == 'arabic') {
      var translation = await translator.translate(newText, to: 'ar');
      newText = translation.text;
    }

    if (!mounted) return;
    setState(() {
      textToSpeak = newText;
      currentGesture = originalText;
    });

    await HistoryStorage.addToHistory(originalText);

    // لا تنطق هنا، النطق يتم عند الضغط على الزر
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _bluetoothInputStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 105, 117, 249),
        title: const Text(
          "Translation",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color.fromARGB(255, 105, 117, 249),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: StreamBuilder<String>(
                  stream: gloveStreamController.stream,
                  builder: (context, snapshot) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.hasData
                              ? "📥 Gesture: ${snapshot.data}"
                              : "No gesture yet...",
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "🗣 Translation:",
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          textToSpeak,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: iconContainer(Icons.volume_up_rounded),
                  onPressed: stop,
                ),
                const SizedBox(width: 6),
                IconButton(
                  icon: iconContainer(Icons.play_arrow_rounded),
                  onPressed: speak,
                ),
                const SizedBox(width: 6),
                IconButton(
                  icon: iconContainer(Icons.pause),
                  onPressed: pause,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

Widget iconContainer(IconData icon) {
  return Container(
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 200, 200, 255),
      borderRadius: BorderRadius.circular(50),
    ),
    padding: const EdgeInsets.all(8),
    child: Icon(icon, color: const Color.fromARGB(255, 5, 29, 72), size: 28),
  );
}