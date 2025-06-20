import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/screens/blutooth.dart';
import 'package:grad_project/screens/glove-stream.dart';
import 'package:grad_project/screens/order.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';


class AddDevice extends StatefulWidget {
  const AddDevice({super.key});

  @override
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  bool isPairSelected = false;
  bool isOrderSelected = false;
Future<void> _checkPermissions() async {
  await [
    Permission.bluetooth,
    Permission.bluetoothScan,
    Permission.bluetoothConnect,
    Permission.location,
  ].request();
}
Future<bool> pairDevice() async {
  
  try {
    await _checkPermissions();

    if (!(await Permission.bluetoothConnect.isGranted)) {
      print("❌ BLUETOOTH_CONNECT permission not granted");
      return false;
    }

    await FlutterBluetoothSerial.instance.requestEnable();

    List<BluetoothDevice> bondedDevices =
        await FlutterBluetoothSerial.instance.getBondedDevices();

for (BluetoothDevice device in bondedDevices) {
  print("📱 Device found: ${device.name} - ${device.address}");
}
    BluetoothDevice? gloveDevice;

    try {
      gloveDevice = bondedDevices.firstWhere(
        (device) =>
            device.name == "Glove" || device.address == "3C:8A:1F:0B:DB:92",
      );
    } catch (e) {
      print("❌ Device not found");
      return false;
    }

    try {
      print("🟢 محاولة الاتصال بالجهاز: ${gloveDevice.name} (${gloveDevice.address})");

      BluetoothConnection connection =
          await BluetoothConnection.toAddress(gloveDevice.address);

      print('✅ Connected to the glove!');

      connection.input!.listen((Uint8List data) {
        String received = String.fromCharCodes(data);
        print('📥 Received: $received');
       
       /////////////////////////////////////
          // أرسل البيانات إلى TranscribePage عبر StreamController
          gloveStreamController.add(received);

        FirebaseFirestore.instance.collection('glove_data').add({
          'gesture': received.trim(),
          'timestamp': Timestamp.now(),
        });
      });

      return true;
    } catch (e) {
      print("❌ Failed to connect: $e");
      return false;
    }
  }
   catch (e) {
    print("❌ General Error: $e");
    return false;
  }
  
}
////////////////UI////////////UI/////////////UI/////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 227, 247),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 227, 227, 247),
        title: Text("           "),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'images/Light Mode Onboard.png',
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              "Check your Blutooth connection!",
              style: TextStyle(
                color: Color.fromARGB(255, 25, 88, 216),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Pair your motion capturing gloves ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 24, 37, 63),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "by clicking on 'Pair' down below",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 9, 14, 24),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "If you don't have gloves yet you can order them by clicking on 'order'",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 9, 14, 24),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),

          
            
// Pair button
GestureDetector(
  onTap: () async {
    await _checkPermissions(); // اطلب الصلاحيات أولًا

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectDevicePage()),
    );
  },
  child: Container(
    width: 280,
    height: 45,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: isPairSelected
          ? Color.fromARGB(255, 210, 207, 255)
          : Color.fromARGB(255, 222, 233, 252),
      border: Border.all(
        color: isPairSelected
            ? Color.fromARGB(255, 106, 94, 237)
            : Color.fromARGB(255, 114, 105, 234),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      'Pair Device',
      style: TextStyle(
        color: isPairSelected
            ? Color.fromARGB(255, 79, 65, 233)
            : Color.fromARGB(255, 79, 66, 111),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  ),
),





            SizedBox(height: 10),

            // Order button
            GestureDetector(
              onTap: () {
       Navigator.push(
                 context,
                MaterialPageRoute(builder: (context) =>  OrderPage()),
                      );
                       },
              child: Container(
                width: 280,
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isOrderSelected
                      ? Color.fromARGB(255, 210, 207, 255)
                      : Color.fromARGB(255, 222, 233, 252),
                  border: Border.all(
                    color: isOrderSelected
                        ? Color.fromARGB(255, 106, 94, 237)
                        : Color.fromARGB(255, 114, 105, 234),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Order',
                  style: TextStyle(
                    color: isOrderSelected
                        ? Color.fromARGB(255, 79, 65, 233)
                        : Color.fromARGB(255, 79, 66, 111),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
