// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:attendx/models/bt_device.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BluetoothController extends GetxController {
  RxBool scanning = true.obs;

  RxList<UniqueBluetoothDevice> devicesList = <UniqueBluetoothDevice>[].obs;
  FlutterScanBluetooth bluetooth = FlutterScanBluetooth();

  @override
  void onReady() {
    super.onReady();
    scanDevices();
  }

  _startScan() async {
    try {
      scanning.value = true;
      await bluetooth.startScan(pairedDevices: false);
      debugPrint("scanning started");
      // }
      // await bluetooth.stopScan();
      // scanning.value = false;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> scanDevices() async {
    _startScan();
    _listenToDevices();
  }

  _listenToDevices() {
    print("...listening");
    bluetooth.devices.listen((device) {
      UniqueBluetoothDevice uniqueDevice = UniqueBluetoothDevice(
        device.name,
        device.address,
      );
      if (!devicesList.contains(uniqueDevice)) {
        devicesList.add(uniqueDevice);
        // print('Added unique device: $uniqueDevice');
      } else {
        // print('Device already exists: $uniqueDevice');
      }
    });

    bluetooth.scanStopped.listen((device) {
      if (scanning.value == true) {
        scanning.value = false;
      }
    });
  }
}

// Stream<BluetoothDevice> get scanResults => _bluetooth.devices;

// Future scanDevices() async {
//   try {
//     if (flutterBluePlus.isScanningNow == false) {
//       print("Not Scanning");
//       await flutterBluePlus.startScan(
//         timeout: const Duration(seconds: 60),
//         allowDuplicates: true,
//         // scanMode: ScanMode.balanced
//       );
//
//       flutterBluePlus.scanResults.listen((event) {
//         print("event");
//         print(event);
//       });
//     } else {
//       print("Scanning Now");
//       flutterBluePlus.scanResults.listen((event) {
//         print("event");
//         print(event);
//       });
//
//       print("State Now");
//       flutterBluePlus.state.listen((event) {
//         print("event state");
//         print(event);
//       });
//     }
//
//
//   } catch (e) {
//     print(e.toString());
//   }
// }

// Stream<List<ScanResult>> get scanResults => flutterBluePlus.scanResults;
