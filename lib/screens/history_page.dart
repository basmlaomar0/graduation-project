import 'package:flutter/material.dart';
import 'history_storage.dart';
import 'package:flutter_tts/flutter_tts.dart';

final FlutterTts flutterTts = FlutterTts();

Future<void> _speak(String text) async {
  await flutterTts.setLanguage("en-US"); // أو "ar-SA" للغة العربية
  await flutterTts.setPitch(1);
  await flutterTts.speak(text);
}

class TranslationHistoryPage extends StatelessWidget {
  const TranslationHistoryPage({super.key});

  Future<void> _clearHistory(BuildContext context) async {
    await HistoryStorage.clearHistory();
    // إعادة تحميل الصفحة بعد الحذف
    // ignore: invalid_use_of_protected_member
    (context as Element).reassemble(); // يعيد بناء الـ FutureBuilder
  }

  void _showClearDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 227, 231, 250), // أزرق فاتح
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Colors.blueAccent, width: 1.5),
        ),
        // title: const Text(
        //   'Clear',
        //   style: TextStyle(
        //     color: Color(0xFF0D47A1),
        //     fontSize: 24,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        content: 
        SizedBox(
           height: 60,
          child: Padding(
            padding: const EdgeInsets.only(top: 9),
            child: Center(
              child: const Text(
                'Are you sure you want to clear history?',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 19,
                ),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Color.fromARGB(255, 82, 81, 81),
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _clearHistory(context);
            },
            child: const Text(
              'Clear',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:Color.fromARGB(255, 204, 213, 244),
      appBar: AppBar(
         backgroundColor:Color.fromARGB(255, 204, 213, 244),
        title: const Text("History",
        style: TextStyle(
            color: Color.fromARGB(255, 25, 101, 163),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),),
           iconTheme: const IconThemeData(
          size: 24,
          color:Color.fromARGB(255, 25, 101, 163),
        ),
        
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: const Icon(Icons.delete, 
              color: Color.fromARGB(255, 25, 101, 163),),
              onPressed: () => _showClearDialog(context),
              
            ),
          )
        ],
      ),
////////////////Test History///////////////////////
    // // ✅ هنا أضفنا الزر المؤقت
    // floatingActionButton: FloatingActionButton(
    //   onPressed: () async {
    //     await HistoryStorage.addToHistory("Manual Test");
    //     (context as Element).reassemble();
    //   },
    //   child: const Icon(Icons.add),
    // ),
////////////////Test History///////////////////
      body: 
      FutureBuilder<List<TranslationHistoryItem>>(
        future: HistoryStorage.getHistory(),
        builder: (context, snapshot) {
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final history = snapshot.data ?? [];

          if (history.isEmpty) {
            return const Center(child: Text('No translations saved yet.'));
          }

        return ListView.builder(
  itemCount: history.length,
  itemBuilder: (context, index) {
    final item = history[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
      child: SizedBox(
        height: 110, // 👈 تحكم في طول الكارد من هنا
        child:Card(
  color: Color.fromARGB(255, 227, 231, 250), // 👈 لون خلفية الكارد (أزرق فاتح كمثال)
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
    side: BorderSide(
      color: const Color.fromARGB(255, 177, 204, 254), // 👈 لون البوردر
      width: 2,               // 👈 سمك البوردر
    ),
  ),
  elevation: 3,
  child: Padding(
    padding: const EdgeInsets.only(left: 18,right: 12,top: 10,bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  const Icon(Icons.history, color: Colors.blue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item.text,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.volume_up, color: Color.fromARGB(255, 25, 101, 163)),
              onPressed: () {
                _speak(item.text);
              },
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          _formatDateTime(item.timestamp),
          style: const TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 91, 89, 89),
          ),
        ),
      ],
    ),
  ),
),

      ),
    );
  },
);

        },
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
  final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
  final minute = dateTime.minute.toString().padLeft(2, '0');
  final period = dateTime.hour >= 12 ? 'PM' : 'AM';
  return '${dateTime.day}/${dateTime.month}/${dateTime.year}      $hour:$minute $period';
}

}
