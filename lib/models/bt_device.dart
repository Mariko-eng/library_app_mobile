import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';

class UniqueBluetoothDevice extends BluetoothDevice {
  UniqueBluetoothDevice(String name, String address) : super(name, address);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is UniqueBluetoothDevice &&
              runtimeType == other.runtimeType &&
              name == other.name;

  @override
  int get hashCode => name.hashCode;
}
