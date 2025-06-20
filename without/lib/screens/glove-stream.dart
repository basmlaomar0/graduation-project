import 'dart:async';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

final StreamController<String> gloveStreamController =
    StreamController<String>.broadcast();

final StreamController<List<double>> gloveStreamBluetoothController =
    StreamController<List<double>>.broadcast();

BluetoothConnection? connection;