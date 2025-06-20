import 'package:flutter/material.dart';
class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 215, 221, 243),
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 215, 221, 243),
        title: Text("FAQ  &  Help",
        style: TextStyle(
            color: Color.fromARGB(255, 25, 101, 163),
            fontSize: 22,
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
          padding: EdgeInsets.only(left: 20),
          child: Text("Frequently Asked Questions",
          style: TextStyle(
            color: const Color.fromARGB(255, 38, 17, 66),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            height: 380,
             alignment: Alignment.topLeft, // لو حابة النص يكون فوق ويسار
             decoration: BoxDecoration(
        color:Color.fromARGB(255, 231, 232, 239),
        border: Border.all(
          color: Color.fromARGB(255, 52, 55, 142), // لون البوردر
          width: 2, // سمك البوردر
        ),
        borderRadius: BorderRadius.circular(10),
      ),
             child: SingleChildScrollView(
              padding: EdgeInsets.all(10),
               child: Text(
          "Q: How do I pair my Bluetooth gloves?\n"
          "A: Turn on your gloves and enable Bluetooth on your device. Press the pairing button on the glove (if available), then select the glove from your device's Bluetooth settings. Follow any on-screen prompts.\n\n"
          "Q: What devices are compatible with Bluetooth gloves?\n"
          "A: Most Bluetooth gloves work with Android, iOS, Windows, and macOS devices that support Bluetooth 4.0 or higher.\n\n"
          "Q: My gloves won’t connect. What should I do?\n"
          "A: Make sure the gloves are fully charged and in pairing mode. Try restarting both your device and the gloves, and ensure no other device is connected to the gloves.\n\n"
          "Q: How long does the battery last?\n"
          "A: Battery life depends on usage and the glove model, but typically lasts between 6 to 12 hours of active use.\n\n"
          "Q: Are Bluetooth gloves washable?\n"
          "A: Usually, no. Electronics inside the gloves make them unsuitable for full washing. Some models allow spot cleaning or have removable electronic parts—check your glove’s manual.\n\n"
          "Q: Can I use them in cold weather?\n"
          "A: Yes! Bluetooth gloves are often designed for winter use, allowing both warmth and tech functionality like typing or gesture control in low temperatures.\n\n"
          "Q: Is calibration required?\n"
          "A: Some advanced Bluetooth gloves (especially gesture-based ones) may need initial calibration for optimal accuracy. Follow the app instructions for setup.\n\n"
          "Q: Can I use voice commands or translation features with the gloves?\n"
          "A: If your gloves are paired with a compatible app (like SignTalk), you can use features like speech-to-text, translation, or voice output depending on your glove's sensors and app support.\n\n"
          "Q: Do I need an app to use the gloves?\n"
          "A: Most Bluetooth gloves require a companion app for setup, customization, and advanced features like gesture recognition or translation.\n\n"
          "Q: Can I use the gloves while charging?\n"
          "A: For safety, most gloves are disabled while charging. Wait until they’re fully charged before use.\n\n"
          "Q: Are there different sizes available?\n"
          "A: Yes. Bluetooth gloves usually come in different sizes (S, M, L, XL). Make sure to choose a snug but comfortable fit for accurate gesture detection.\n\n"
          "Q: How do I update the firmware on my gloves?\n"
          "A: Firmware updates are handled through the companion app. Make sure your gloves are connected via Bluetooth and follow the update instructions within the app.\n\n"
          "Q: Do the gloves support multiple languages for translation?\n"
          "A: If you’re using a translation-enabled app like SignTalk, yes — multiple languages are supported. You can usually select your preferred language in the app settings.\n\n"
          "Q: Can I connect the gloves to more than one device?\n"
          "A: Some gloves support multi-device pairing, but typically only one connection is active at a time. Check your glove model's manual for details.\n\n"
          "Q: What gestures are supported?\n"
          "A: Common gestures include finger taps, swipes, and sign language movements. The app may let you customize gestures for specific actions.\n\n"
          "Q: Is there a warranty?\n"
          "A: Most Bluetooth gloves come with a 6–12 month warranty. Check with the manufacturer or retailer for specifics.",
          style: TextStyle(
    fontSize: 14,
    color: Color.fromARGB(255, 38, 17, 66),
    height: 1.5,
  ),
),
             ),

  ),
),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,  // لضبط المحتوى عمودياً في المنتصف
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
  padding: EdgeInsets.all(20),
  child: ClipRRect(
     borderRadius: BorderRadius.circular(10),
    child: Container(
      width: 140,
      height: 120,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 183, 187, 232),
        border: Border.all(
          color: Color.fromARGB(255, 52, 55, 142), // لون البوردر
          width: 2, // سمك البوردر
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.feedback, size: 50, color: Color.fromARGB(255, 52, 55, 142)),
          SizedBox(height: 10),
          Text(
            'Send Feedback',
            style: TextStyle(
              color: Color.fromARGB(255, 52, 55, 142),
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    ),
  ),
),
    
    Padding(
      padding: EdgeInsets.only(left: 0),
      child: ClipRRect(
       borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 140,
        height: 120,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 183, 187, 232),
          border: Border.all(
            color: Color.fromARGB(255, 52, 55, 142), // لون البوردر
            width: 2, // سمك البوردر
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.support, size: 50, color: Color.fromARGB(255, 52, 55, 142)),
            SizedBox(height: 10),
            Text(
              'Contact Support',
              style: TextStyle(
                color: Color.fromARGB(255, 52, 55, 142),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
        ),
    ),

          ],
        ),
        ],
      ),
    );
  }
}
