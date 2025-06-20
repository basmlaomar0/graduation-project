import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

BluetoothConnection? connection;
StreamSubscription<Uint8List>? _subscription;
StreamController<String> gloveStreamController = StreamController<String>.broadcast();

Stream<Uint8List>? _bluetoothInputStream;

void startListeningToBluetooth(Function(String) onGestureReceived) {
  if (connection?.input == null || _subscription != null) return;

  _bluetoothInputStream ??= connection!.input!.asBroadcastStream();

  _subscription = _bluetoothInputStream!.listen((event) {
    try {
      final data = String.fromCharCodes(event).trim();
      if (data.isNotEmpty) {
        gloveStreamController.sink.add(data);
        onGestureReceived(data);
      }
    } catch (e) {
      print("❌ Error decoding data: $e");
    }
  }, onError: (err) {
    print("❌ Stream error: $err");
  }, cancelOnError: true);
}