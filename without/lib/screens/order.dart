
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BluetoothStatusScreen();
  }}

class BluetoothStatusScreen extends StatefulWidget {
  @override
  _BluetoothStatusScreenState createState() => _BluetoothStatusScreenState();
}

class _BluetoothStatusScreenState extends State<BluetoothStatusScreen> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  @override
  void initState() {
    super.initState();
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    FlutterBluetoothSerial.instance.onStateChanged().listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String statusText;
    switch (_bluetoothState) {
      case BluetoothState.STATE_ON:
        statusText = "Bluetooth is ON";
        break;
      case BluetoothState.STATE_OFF:
        statusText = "Bluetooth is OFF";
        break;
      default:
        statusText = "Bluetooth status unknown";
    }

    return Scaffold(
     appBar: AppBar(
  title: Text("Bluetooth Status"),
  iconTheme: const IconThemeData(
    size: 24,
    color: Color.fromARGB(255, 25, 101, 163),
  ),
),

      body: Center(
        child: Text(
          statusText,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
