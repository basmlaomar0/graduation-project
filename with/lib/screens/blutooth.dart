import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:grad_project/screens/failure-page.dart';
import 'package:grad_project/screens/glove-stream.dart';
import 'package:grad_project/screens/success-page.dart';
import 'package:permission_handler/permission_handler.dart';

class SelectDevicePage extends StatefulWidget {
  @override
  _SelectDevicePageState createState() => _SelectDevicePageState();
}

class _SelectDevicePageState extends State<SelectDevicePage> {
  List<BluetoothDevice> devices = [];
  bool isLoading = true;

  StreamSubscription<List<int>>? _subscription;
  @override
  void initState() {
    super.initState();
    requestPermissions().then((_) => getBondedDevices());
  }


  Future<void> requestPermissions() async {
    await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
      Permission.location,
    ].request();
  }

  Future<void> getBondedDevices() async {
    try {
      List<BluetoothDevice> bonded =
          await FlutterBluetoothSerial.instance.getBondedDevices();
      setState(() {
        devices = bonded;
        isLoading = false;
      });
    } catch (e) {
      print("❌ Error fetching bonded devices: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error fetching bonded devices")));
    }
  }
void connectToDevice(BluetoothDevice device) async {
  try {
    await FlutterBluetoothSerial.instance.cancelDiscovery(); // مهم لإيقاف البحث

    connection = await BluetoothConnection.toAddress(device.address);

    print("✅ Connected to ${device.name}");
    await _subscription?.cancel();
_subscription = null;
startListeningToBluetooth((data) {
  print("📥 Received gesture: $data");
});


    // إرسال رسالة اختبارية (اختياري)
    connection?.output.add(
      Uint8List.fromList(utf8.encode("Hello from Flutter!\n")),
    );

    // استقبال البيانات (اختياري)
    connection?.input?.listen((data) {
      print("📥 Received: ${utf8.decode(data)}");
    });

    // الانتقال إلى صفحة النجاح
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuccessPage()),
    );
  } catch (e) {
    print("❌ Failed to connect: $e");

    // الانتقال إلى صفحة الفشل
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FailurePage()),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 226, 226, 251),
      appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 226, 226, 251),
        title: Text("Select Bluetooth Device",
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
     body: isLoading
    ? Center(child: CircularProgressIndicator())
    : devices.isEmpty
        ? Center(
            child: Text(
              "No paired devices found",
              style: TextStyle(
                color: Color.fromARGB(255, 25, 101, 163),
                fontSize: 22,
                
              ),
            ),
          )
        : ListView.builder(
            itemCount: devices.length,
            itemBuilder: (context, index) {
              final device = devices[index];
             return Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  child: GestureDetector(
    onTap: () => connectToDevice(device), // ✅ هنا استدعاء الدالة
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: const Color.fromARGB(255, 177, 204, 254),
          width: 2,
        ),
      ),
      color: const Color.fromARGB(255, 213, 219, 251),
      elevation: 4,
      child: Container(
        height: 85,
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.bluetooth, size: 35, color: Colors.blue),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    device.name ?? "Unknown",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    device.address,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);

            },
          ),
 

    );
  }
}