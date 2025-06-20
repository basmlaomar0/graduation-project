import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TranslationHistoryItem {
  final String text;
  final DateTime timestamp;

  TranslationHistoryItem({required this.text, required this.timestamp});

  Map<String, dynamic> toJson() => {
        'text': text,
        'timestamp': timestamp.toIso8601String(),
      };

  factory TranslationHistoryItem.fromJson(Map<String, dynamic> json) {
    return TranslationHistoryItem(
      text: json['text'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

class HistoryStorage {
  static const String _key = 'translation_history';

  static Future<void> addToHistory(String translatedText) async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();

    final newItem = TranslationHistoryItem(text: translatedText, timestamp: now);
    final existingData = prefs.getStringList(_key) ?? [];

    existingData.add(jsonEncode(newItem.toJson()));
     print("📝 Saving to history: $translatedText"); // 👈 تتبع

    await prefs.setStringList(_key, existingData);

    
  // Optional: اطبع المحتوى بعد التخزين
  print("📦 Current history: $existingData");
  
  }

  static Future<List<TranslationHistoryItem>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];

    return data.map((item) {
      final jsonItem = jsonDecode(item);
      return TranslationHistoryItem.fromJson(jsonItem);
    }).toList().reversed.toList();
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
