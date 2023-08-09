import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendx/controllers/blue_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String _data = '';
  // bool _scanning = false;
  // FlutterScanBluetooth _bluetooth = FlutterScanBluetooth();
  //
  // _startScan() async{
  //   try {
  //     if(_scanning) {
  //       await _bluetooth.stopScan();
  //       debugPrint("scanning stoped");
  //       setState(() {
  //         _data = '';
  //       });
  //     }
  //     else {
  //       await _bluetooth.startScan(pairedDevices: false);
  //       debugPrint("scanning started");
  //       setState(() {
  //         _scanning = true;
  //       });
  //     }
  //   } on PlatformException catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  @override
  void initState() {
    super.initState();

    // _startScan();
    //
    // _bluetooth.devices.listen((device) {
    //   setState(() {
    //     _data += device.name+' (${device.address})\n';
    //   });
    // });
    // _bluetooth.scanStopped.listen((device) {
    //   setState(() {
    //     _scanning = false;
    //     _data += 'scan stopped\n';
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    // print("_scanning " + _scanning.toString());
    // print("_data "+_data);
    final BluetoothController controller = Get.put(BluetoothController());

    return Obx(() {
      print("Scanning : ${controller.scanning}");

      return Scaffold(
        appBar: AppBar(
          title: const Text("AttendX"),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(children: [
                controller.scanning.isTrue
                    ? const SizedBox(
                        height: 5,
                        width: 5,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        "Refresh",
                        style: TextStyle(color: Colors.white),
                      )
              ]),
            )
          ],
        ),
        body: controller.devicesList.isEmpty
            ? Center(child: Text("No Devices Found"))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: controller.devicesList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Text(controller.devicesList[index].name),
                    ),
                  );
                }),
      );
    });
  }
}
